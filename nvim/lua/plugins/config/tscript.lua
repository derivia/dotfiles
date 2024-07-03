local status_ok, plugin = pcall(require, "typescript-tools")
if not status_ok then
	vim.notify("plugin" .. plugin .. "failed to start")
	return
end

local methods = vim.lsp.protocol.Methods

local on_attach = function(client, bufnr)
	local function keymap(lhs, rhs, desc, mode)
		mode = mode or "n"
		vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
	end

	if client.supports_method(methods.textDocument_definition) then
		keymap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to definition")
		keymap("K", "<cmd>lua vim.lsp.buf.hover()<CR>", "Peek definition")
	end
	if client.supports_method(methods.textDocument_declaration) then
		keymap("gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", "Go to declaration")
	end
	if client.supports_method(methods.textDocument_signatureHelp) then
		keymap("gK", "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature help")
	end
	if client.supports_method(methods.textDocument_implementation) then
		keymap("gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", "Go to implementation")
	end
	if client.supports_method(methods.textDocument_codeAction) then
		keymap("ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code actions", { "n", "x" })
	end
end

plugin.setup({
	on_attach = on_attach,
	settings = {
		separate_diagnostic_server = true,
		publish_diagnostic_on = "insert_leave",
		tsserver_max_memory = "auto",
		tsserver_file_preferences = {
			quotePreference = "double",
			includeCompletionsForModuleExports = true,
			includeCompletionsForImportStatements = true,
			importModuleSpecifierEnding = "index",
		},
		tsserver_locale = "en",
		expose_as_code_action = "all",
		complete_function_calls = false,
		include_completions_with_insert_text = true,
		code_lens = "off",
		disable_member_code_lens = true,
		jsx_close_tag = {
			enable = false,
			filetypes = { "javascriptreact", "typescriptreact" },
		},
	},
})
