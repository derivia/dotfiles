local status_ok_lspconfig, lspconfig = pcall(require, "lspconfig")
local status_ok_cmp_lsp, cmp_lsp = pcall(require, "cmp_nvim_lsp")

if not status_ok_lspconfig and status_ok_cmp_lsp then
	return
end

local methods = vim.lsp.protocol.Methods

local util = require("lspconfig.util")

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = false,
	signs = {
		severity = {
			vim.diagnostic.severity.WARN,
			vim.diagnostic.severity.ERROR,
		},
	},
	virtual_text = {
		spacing = 2,
		severity = {
			vim.diagnostic.severity.WARN,
			vim.diagnostic.severity.ERROR,
		},
	},
})

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

local capabilities = function()
	return vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), cmp_lsp.default_capabilities())
end

require("lspconfig.ui.windows").default_options.border = "rounded"

lspconfig.lua_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities(),
	on_init = function(client)
		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				version = "LuaJIT",
			},
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
				},
			},
		})
	end,
	settings = {
		Lua = {
			diagnostics = {
				-- get the language server to recognize the `vim` global
				globals = { "vim" },
			},
		},
	},
})

local servers = {
	"clangd",
	"prismals",
	-- "tsserver",
}

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities(),
	})
end
