---@type vim.lsp.Config
return {
	on_attach = function(client)
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end,

	-- TypeScript 7 content mappers (reylo, proto-mapper, ...) spawn external processes, so the
	-- language server needs an explicit opt-in at initialize time. Without it, every tsconfig
	-- declaring `contentMappers` shows error 18068 and the mapped imports (.sql, .proto, ...)
	-- show TS2307 "Cannot find module". `tsc --lsp` takes no CLI flag for this; it only reads
	-- initializationOptions, which is what `init_options` becomes here.
	init_options = {
		runExternalCode = true,
	},

	-- The shipped filetypes plus content-mapped ones, so the client didOpens `.proto` buffers
	-- too: mapper diagnostics (protoc errors) then show inside the .proto file itself, and
	-- hover works there, with tsgo mapping positions through the content mapper's span maps.
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"proto",
	},
}
