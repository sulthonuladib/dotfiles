-- Early pack hooks (must load before `vim.pack.add`)
require("sulthonuladib.plugins.pack-hooks")

---@type (string | vim.pack.Spec)[]
local plugins = {
	-- NvChad UI / base46 theming (completion popup, signature help, floats)
	"https://github.com/NvChad/ui",
	"https://github.com/NvChad/base46",

	-- File explorer
	{ src = "https://github.com/stevearc/oil.nvim", version = "v2.16.0" },

	-- Telescope
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-telescope/telescope-ui-select.nvim",

	-- LSP stack
	"https://github.com/j-hui/fidget.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",

	-- Completion
	{ src = "https://github.com/L3MON4D3/LuaSnip", version = vim.version.range("2.*") },
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },

	-- Formatting
	"https://github.com/stevearc/conform.nvim",

	-- Treesitter
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },

	"https://github.com/supermaven-inc/supermaven-nvim",
}

if vim.fn.executable("make") == 1 then
	table.insert(plugins, "https://github.com/nvim-telescope/telescope-fzf-native.nvim")
end

vim.pack.add(plugins)

-- Apply the NvChad base46 highlights before the UI plugins are configured.
require("sulthonuladib.base46")

-- Core
require("sulthonuladib.plugins.oil")
require("sulthonuladib.plugins.telescope")
require("sulthonuladib.plugins.blink")
require("sulthonuladib.plugins.conform")
require("sulthonuladib.plugins.treesitter")

-- LSP
require("sulthonuladib.plugins.lsp.mason") -- mason has to load before lspconfig
require("sulthonuladib.plugins.lsp.lspconfig")

-- ai
require("sulthonuladib.plugins.supermaven")
