local add_keymap = vim.keymap.set

require("fidget").setup({})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("personal-lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		map("<leader>rn", vim.lsp.buf.rename, "Rename it baby")
		map("<leader>vd", vim.diagnostic.open_float, "diagnostic floating")

		local client = vim.lsp.get_client_by_id(event.data.client_id)

		-- NvChad's minimal auto signature window.
		if client and client.server_capabilities.signatureHelpProvider then
			require("nvchad.lsp.signature").setup(client, event.buf)
		end

		if client and client:supports_method("textDocument/documentHighlight", event.buf) then
			local highlight_augroup = vim.api.nvim_create_augroup("personal-lsp-highlight", { clear = false })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("personal-lsp-detach", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "personal-lsp-highlight", buffer = event2.buf })
				end,
			})
		end
	end,
})

vim.diagnostic.config({
	update_in_insert = true,
	severity_sort = true,
	signs = true,
	float = { border = "rounded", source = "if_many" },
	underline = { severity = { min = vim.diagnostic.severity.WARN } },

	-- Can switch between these as you prefer
	virtual_text = true, -- Text shows up at the end of the line
	virtual_lines = false, -- Text shows up underneath the line, with virtual lines

	-- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
	jump = {
		on_jump = function(_, bufnr)
			vim.diagnostic.open_float({
				bufnr = bufnr,
				scope = "cursor",
				focus = false,
			})
		end,
	},
})
-- add_keymap("n", "<leader>vd", vim.diagnostic.open_float, { desc = "Open diagnostics" })
-- TODO: we might remove this as we are going to use blink
-- add_keymap("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename with the references" })
add_keymap("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
add_keymap("n", "<leader>vca", vim.lsp.buf.code_action, { desc = "Code action" })
add_keymap("n", "<leader>k", vim.lsp.buf.hover, { desc = "Hover" })
add_keymap("i", "<C-h>", function()
	vim.lsp.buf.signature_help({
		border = "single",
	})
end, { desc = "Signature Help" })

-- Per-server configs live next to this file. Register the ones that need it;
-- the rest are picked up by lspconfig's shipped defaults.
vim.lsp.config("lua_ls", require("sulthonuladib.plugins.lsp.lua_ls"))
vim.lsp.config("tsc", require("sulthonuladib.plugins.lsp.tsc"))
vim.lsp.config("stylua", require("sulthonuladib.plugins.lsp.stylua"))
vim.lsp.config("jsonls", {
	on_attach = function(client)
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end,
})

-- Attach the HTML language server to templ buffers too. The shipped
-- `tailwindcss` config already includes `templ` and maps it to `html` via
-- `tailwindCSS.includeLanguages`, and `templ` itself ships with `filetypes = { 'templ' }`.
vim.lsp.config("html", {
	filetypes = { "html", "templ" },
})

-- htmx-lsp copies tailwindcss-intellisense's filetype list, which includes
-- javascript/typescript. It never answers `textDocument/completion` there,
-- and blink.cmp waits for every attached client before it shows results, so
-- htmx on a .ts buffer silently blocks tsc's completions. Keep htmx on markup.
vim.lsp.config("htmx", {
	filetypes = {
		"html",
		"htmldjango",
		"django-html",
		"htmlangular",
		"templ",
		"gohtml",
		"gohtmltmpl",
		"heex",
		"ejs",
		"erb",
		"eruby",
		"blade",
		"astro",
		"svelte",
		"vue",
		"php",
		"twig",
		"liquid",
		"handlebars",
		"hbs",
		"mustache",
		"njk",
		"nunjucks",
		"haml",
		"slim",
		"jade",
	},
})

vim.lsp.enable({ "lua_ls", "tsc", "stylua", "jsonls", "gopls", "templ", "html", "tailwindcss" })
