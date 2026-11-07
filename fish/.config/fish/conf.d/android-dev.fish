# Android development (Keroid and other Android projects).
# Stow exposes this file at ~/.config/fish/conf.d/android-dev.fish.
# Use the official `android` CLI for SDK/device management; sdkmanager is optional.

if not set -q ANDROID_HOME
    set -gx ANDROID_HOME "$HOME/Android/Sdk"
end

# Pinned to the NDK used by Keroid's Go mobile build. Respect explicit overrides.
if not set -q ANDROID_NDK_HOME; and test -d "$ANDROID_HOME/ndk/29.0.14206865"
    set -gx ANDROID_NDK_HOME "$ANDROID_HOME/ndk/29.0.14206865"
end

# Fallback outside mise-managed projects. The stable mise link follows JDK 17
# patch upgrades; a project's mise config can still select a different JDK.
if not set -q JAVA_HOME; and test -x "$HOME/.local/share/mise/installs/java/temurin-17/bin/java"
    set -gx JAVA_HOME "$HOME/.local/share/mise/installs/java/temurin-17"
end

# --path changes this shell's PATH, not universal fish_user_paths. Appending keeps
# mise shims and existing tool selections ahead of these fallbacks. Re-sourcing
# is safe: fish_add_path does not duplicate entries and skips missing directories.
fish_add_path --path --append \
    "$ANDROID_HOME/platform-tools" \
    "$ANDROID_HOME/emulator" \
    "$ANDROID_HOME/cmdline-tools/latest/bin" \
    "$HOME/go/bin"

if set -q JAVA_HOME
    fish_add_path --path --append "$JAVA_HOME/bin"
end
