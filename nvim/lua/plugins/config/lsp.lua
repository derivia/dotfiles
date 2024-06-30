local status_ok_lspconfig, lspconfig = pcall(require, "lspconfig")

if not status_ok_lspconfig then
	vim.notify("plugin " .. lspconfig .. " failed to start.")
	return
end

-- rounded border on :LspInfo
require("lspconfig.ui.windows").default_options.border = "rounded"

local on_attach = function(_, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		---@diagnostic disable-next-line: deprecated
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	local opts = { noremap = true, silent = true }
	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "gK", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = false,
	signs = {
		severity = {
			vim.diagnostic.severity.WARN,
			vim.diagnostic.severity.ERROR,
		},
	},
	virtual_text = {
		spacing = 4,
		severity = {
			vim.diagnostic.severity.WARN,
			vim.diagnostic.severity.ERROR,
		},
	},
})

lspconfig.lua_ls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
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

lspconfig.solargraph.setup({
	capabilities = capabilities,
	init_options = {
		formatting = false,
	},
})

local servers = {
	"clangd",
	"html",
	"prismals",
	"rust_analyzer",
	"tsserver",
}

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end
