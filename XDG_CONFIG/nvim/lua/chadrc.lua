-- NvChad/ui + base46 configuration.
--
-- Only the pieces we actually want are enabled: the completion popup
-- (blink.cmp menu + per-kind colors), signature help, floats and syntax.
-- The tabufline (buffer/tab bar) and statusline are deliberately OFF.
--
-- The `ui.cmp.style` values match NvChad: default | flat_light | flat_dark |
-- atom | atom_colored. `base46.theme` accepts any theme from NvChad/base46.
return {
	base46 = {
		theme = "catppuccin",
		transparency = false,

		-- Keep every float (hover, signature, diagnostics) visually in sync
		-- with the blink.cmp popups, which use bg=black, border=grey_fg.
		hl_override = {
			NormalFloat = { bg = "black" },
			FloatBorder = { fg = "grey_fg" },
		},
	},

	ui = {
		cmp = {
			style = "default",
			icons_left = true,
			abbr_maxwidth = 60,
			-- Colorize color values (hex, tailwind, css) in the popup.
			format_colors = { lsp = true, icon = "󱓻" },
		},

		-- No buffer/tab bar.
		tabufline = { enabled = false },
		-- No statusline (keep Neovim's default).
		statusline = { enabled = false },
	},

	-- Minimal auto signature window (see nvchad/lsp/signature.lua).
	lsp = { signature = true },
}
