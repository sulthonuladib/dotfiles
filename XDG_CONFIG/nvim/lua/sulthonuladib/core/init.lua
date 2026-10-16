-- NvChad base46 caches its compiled highlights here (see
-- lua/sulthonuladib/base46.lua). Must be set before the plugins are loaded.
vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46/"

require("sulthonuladib.core.options")
require("sulthonuladib.core.keymaps")
require("sulthonuladib.core.autocmds")
