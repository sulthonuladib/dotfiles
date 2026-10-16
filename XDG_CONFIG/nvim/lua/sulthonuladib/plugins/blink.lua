require("luasnip").setup({})

-- NvChad's completion menu + kind icons. Colours come from base46 (see
-- lua/chadrc.lua), so they follow the active theme.
local nvchad_menu = require("nvchad.blink").menu
local kind_icons = require("nvchad.icons.lspkind")

require("blink.cmp").setup({
	keymap = {
		-- 'default' (recommended) for mappings similar to built-in completions
		--   <c-y> to accept ([y]es) the completion.
		--    This will auto-import if your LSP supports it.
		--    This will expand snippets if the LSP sent a snippet.
		-- 'super-tab' for tab to accept
		-- 'enter' for enter to accept
		-- 'none' for no mappings
		--
		-- For an understanding of why the 'default' preset is recommended,
		-- you will need to read `:help ins-completion`
		--
		-- No, but seriously. Please read `:help ins-completion`, it is really good!
		--
		-- All presets have the following mappings:
		-- <tab>/<s-tab>: move to right/left of your snippet expansion
		-- <c-space>: Open menu or open docs if already open
		-- <c-n>/<c-p> or <up>/<down>: Select next/previous item
		-- <c-e>: Hide menu
		-- <c-k>: Toggle signature help
		--
		-- See `:help blink-cmp-config-keymap` for defining your own keymap
		preset = "default",
		["<C-k>"] = { "select_and_accept", "fallback" },
		["<C-y"] = false,

		-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
		--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
	},

	appearance = {
		nerd_font_variant = "normal",
		kind_icons = kind_icons,
	},

	completion = {
		-- NvChad's menu: single border, kind icons and per-kind colours.
		menu = nvchad_menu,

		-- By default, you may press `<c-space>` to show the documentation.
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 100,
			window = { border = "single" },
		},
	},

	sources = {
		default = { "lsp", "buffer", "path", "snippets" },
	},
	snippets = { preset = "luasnip" },
	fuzzy = { implementation = "lua" },

	-- Signature help is rendered by nvchad.lsp.signature (wired in
	-- lspconfig.lua), so keep blink's own signature window off to avoid
	-- two popups fighting over the same spot.
	signature = { enabled = false },
})
