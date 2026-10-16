import QtQuick
import Quickshell.Io
import qs.Ui

// Live network throughput for the Omarchy bar: download and upload in MB/s.
//
// Wired up from shell.json as a custom QML module:
//
//   { "id": "net-speed", "type": "qml", "pollMs": 1000 }
//
// which resolves to ~/.config/omarchy/bar/modules/net-speed.qml. Every key
// below is optional and read from that same entry:
//
//   unit          "MB/s" (1000-based, default) · "MiB/s" (1024-based) · "KB/s" …
//   showUnit      false keeps the unit in the tooltip only
//   iconDown      mark drawn before the download figure (default "↓")
//   iconUp        mark drawn before the upload figure   (default "↑")
//   pollMs        sampling period in ms (default 1000, min 250)
//   interface     pin the reading to one link, e.g. "eno1"; empty follows the
//                 default route
//   smoothing     0..1, higher is steadier but slower to react (default 0)
//   onClick       command for a left click  (default: network popup)
//   onRightClick  command for a right click (default: btop)
//
// Counters come from /proc/net/dev and the default route from /proc/net/route,
// so the widget needs no helper script and keeps no state outside itself. Each
// bar instance samples on its own timer, so a bar on every monitor still shows
// the true rate on every screen.
BarWidget {
  id: root
  moduleName: "net-speed"

  readonly property string unit: String(setting("unit", "MB/s"))
  readonly property bool unitVisible: setting("showUnit", true) === true
  readonly property string iconDown: String(setting("iconDown", "↓"))
  readonly property string iconUp: String(setting("iconUp", "↑"))
  readonly property int pollMs: Math.max(250, Number(setting("pollMs", 1000)))
  readonly property string pinnedIface: String(setting("interface", ""))
  readonly property real smoothing: Math.max(0, Math.min(1, Number(setting("smoothing", 0))))
  readonly property string clickCommand: String(setting("onClick", "omarchy-shell -q shell toggle omarchy.network"))
  readonly property string rightClickCommand: String(setting("onRightClick", "omarchy-launch-or-focus-tui btop"))

  // "MiB/s" and friends are 1024-based; plain "MB/s" is 1000-based.
  readonly property real divisor: {
    var u = root.unit
    if (u.indexOf("GiB") === 0) return 1073741824
    if (u.indexOf("MiB") === 0) return 1048576
    if (u.indexOf("KiB") === 0) return 1024
    if (u.indexOf("GB") === 0) return 1000000000
    if (u.indexOf("KB") === 0) return 1000
    return 1000000
  }

  property string routeIface: ""
  property bool ready: false
  property real downRate: 0
  property real upRate: 0
  property real prevRx: 0
  property real prevTx: 0
  property double prevMs: 0
  property bool haveSample: false

  readonly property string iface: pinnedIface !== "" ? pinnedIface : routeIface
  readonly property string downText: format(downRate)
  readonly property string upText: format(upRate)

  readonly property string label: ready
    ? iconDown + downText + " " + iconUp + upText + (unitVisible ? " " + unit : "")
    : ""

  readonly property string tooltip: {
    if (!ready) return "Network speed · no interface"
    var where = iface !== "" ? iface : "all interfaces"
    return where + "\nDown: " + downText + " " + unit + "\nUp: " + upText + " " + unit
  }

  // Wide enough not to jitter: two decimals below 10, then one, then none.
  function format(rate) {
    if (rate >= 100) return rate.toFixed(0)
    if (rate >= 10) return rate.toFixed(1)
    return rate.toFixed(2)
  }

  // Sum the counters of the interfaces we care about. Rows are
  // "  wlp4s0: <rx bytes> … <tx bytes> …" with varying indentation, so the
  // name is split off first and the counters indexed from there.
  function readCounters(raw, want) {
    var result = { rx: 0, tx: 0, found: false }
    var lines = String(raw || "").split("\n")

    for (var i = 2; i < lines.length; i++) {   // two header lines
      var line = lines[i]
      var colon = line.indexOf(":")
      if (colon < 0) continue

      var name = line.substring(0, colon).trim()
      if (name === "" || name === "lo") continue
      if (want !== "" && name !== want) continue

      var fields = line.substring(colon + 1).trim().split(/\s+/)
      if (fields.length < 9) continue

      result.rx += Number(fields[0]) || 0
      result.tx += Number(fields[8]) || 0
      result.found = true
    }

    return result
  }

  // An IPv4 default route is a row with an all-zero destination and mask.
  function defaultInterface(raw) {
    var lines = String(raw || "").split("\n")

    for (var i = 1; i < lines.length; i++) {
      var f = lines[i].trim().split(/\s+/)
      if (f.length >= 8 && f[1] === "00000000" && f[7] === "00000000") return f[0]
    }

    return ""
  }

  function sample(raw) {
    var counters = readCounters(raw, iface)

    if (!counters.found) {
      // Interface is down or gone: collapse the widget instead of showing a
      // stale figure, and start over from a clean baseline when it returns.
      ready = false
      haveSample = false
      return
    }

    var now = Date.now()

    if (haveSample) {
      var dt = (now - prevMs) / 1000
      if (dt > 0) {
        var down = delta(counters.rx, prevRx) / dt / divisor
        var up = delta(counters.tx, prevTx) / dt / divisor
        // smoothing 0 reacts instantly; higher values average the jitter out.
        var weight = smoothing > 0 ? 1 - smoothing : 1
        downRate = downRate * (1 - weight) + down * weight
        upRate = upRate * (1 - weight) + up * weight
      }
    } else {
      downRate = 0
      upRate = 0
    }

    prevRx = counters.rx
    prevTx = counters.tx
    prevMs = now
    haveSample = true
    ready = true
  }

  // A counter that moved backwards means the link reset or we switched
  // interface; count that interval as zero rather than subtracting traffic.
  function delta(current, previous) {
    return current < previous ? 0 : current - previous
  }

  FileView {
    id: routeFile
    path: "/proc/net/route"
    watchChanges: false
    blockLoading: true
    printErrors: false
    onLoaded: root.routeIface = root.defaultInterface(text())
    onLoadFailed: root.routeIface = ""
  }

  FileView {
    id: devFile
    path: "/proc/net/dev"
    watchChanges: false
    blockLoading: true
    printErrors: false
    onLoaded: root.sample(text())
  }

  Timer {
    interval: root.pollMs
    running: true
    repeat: true
    triggeredOnStart: true
    onTriggered: {
      routeFile.reload()
      devFile.reload()
    }
  }

  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  WidgetButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    text: root.label
    tooltipText: root.tooltip

    // A vertical bar is only 28px wide — too narrow for the full label — so
    // it falls back to the two figures stacked, with the unit and interface in
    // the tooltip.
    labelVisible: !root.vertical
    fixedHeight: root.vertical ? verticalFigures.implicitHeight + scaledVerticalPadding * 2 : -1

    Text {
      id: verticalFigures
      visible: root.vertical && root.ready
      anchors.centerIn: parent
      text: root.downText + "\n" + root.upText
      color: button.foreground
      font.family: button.fontFamily
      font.pixelSize: button.fontSize
      horizontalAlignment: Text.AlignHCenter
      lineHeight: 0.85
      lineHeightMode: Text.ProportionalHeight
      renderType: Text.NativeRendering
    }

    onPressed: function (mouseButton) {
      if (!root.bar || typeof root.bar.run !== "function") return
      var command = mouseButton === Qt.RightButton ? root.rightClickCommand : root.clickCommand
      if (command !== "") root.bar.run(command)
    }
  }
}
