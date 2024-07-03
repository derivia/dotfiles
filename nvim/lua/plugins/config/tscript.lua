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
		keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
		keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
	end
	if client.supports_method(methods.textDocument_declaration) then
		keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
	end
	if client.supports_method(methods.textDocument_signatureHelp) then
		keymap("n", "gK", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
	end
	if client.supports_method(methods.textDocument_implementation) then
		keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
	end
end

plugin.setup({
	on_attach = on_attach,
	settings = {
		separate_diagnostic_server = true,
		publish_diagnostic_on = "insert_leave",
		expose_as_code_action = { "all" },
		tsserver_path = nil,
		tsserver_plugins = {},
		tsserver_max_memory = "auto",
		tsserver_format_options = {},
		tsserver_file_preferences = {},
		tsserver_locale = "en",
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
