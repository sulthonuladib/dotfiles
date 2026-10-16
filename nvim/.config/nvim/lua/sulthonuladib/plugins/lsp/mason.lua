require("mason").setup({})
require("mason-lspconfig").setup({
	automatic_enable = true, -- Change this to true if you want to automatically enable servers that are installed manually (e.g. via :Mason / :MasonInstall)
})
require("mason-tool-installer").setup({
	ensure_installed = {
		"lua_ls",
		"tsc",
		"stylua",
		"oxfmt",
		"oxlint",
		"jsonls",
		"gopls",
		"rust_analyzer",
		-- Go templ support (html LSP and tailwindcss LSP also attach to `templ` buffers)
		"templ",
		"html",
		"tailwindcss",
		-- You can add other tools here that you want Mason to install
	},
})
