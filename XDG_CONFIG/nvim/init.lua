vim.loader.enable(true)

-- Ensure .templ buffers have the filetype expected by templ, html, and
-- Tailwind language servers before any LSP configs are enabled.
vim.filetype.add({ extension = { templ = "templ" } })

-- require("vim._core.ui2").enable({
-- 	enable = true,
-- 	msg = {
-- 		target = "cmd",
-- 		pager = { height = 0.5 },
-- 		dialog = { height = 0.5 },
-- 		cmd = { height = 0.5 },
-- 		msg = { height = 0.5, timeout = 4500 },
-- 	},
-- })

require("sulthonuladib.core")
require("sulthonuladib.pack")
require("sulthonuladib.commands")
