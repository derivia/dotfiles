local status_ok_lspconfig, lspconfig = pcall(require, "lspconfig")
local status_ok_cmp_lsp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
local status_ok_tstools, tstools = pcall(require, "typescript-tools")

if not status_ok_lspconfig and status_ok_cmp_lsp and status_ok_tstools then
	return
end

local methods = vim.lsp.protocol.Methods

local util = require("lspconfig.util")

local handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
	["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
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
	}),
}

local on_attach = function(client, bufnr)
	local function keymap(lhs, rhs, desc, mode)
		mode = mode or "n"
		vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
	end

	if client.supports_method(methods.textDocument_definition) then
		keymap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to definition", "n")
		keymap("K", "<cmd>lua vim.lsp.buf.hover()<CR>", "Peek definition", "n")
	end
	if client.supports_method(methods.textDocument_rename) then
		keymap("rn", "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename symbol", { "n", "x" })
	end
	if client.supports_method(methods.textDocument_declaration) then
		keymap("gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", "Go to declaration", "n")
	end
	if client.supports_method(methods.textDocument_signatureHelp) then
		keymap("gK", "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature help", "n")
	end
	if client.supports_method(methods.textDocument_implementation) then
		keymap("gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", "Go to implementation", "n")
	end
	if client.supports_method(methods.textDocument_codeAction) then
		keymap("ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code actions", { "n", "x" })
	end
end

local capabilities = function()
	return vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), cmp_lsp.default_capabilities())
end

require("lspconfig.ui.windows").default_options.border = "rounded"

lspconfig.lua_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities(),
	handlers = handlers,
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

tstools.setup({
	on_attach = on_attach,
	capabilities = capabilities(),
	handlers = handlers,
	single_file_support = true,
	settings = {
		separate_diagnostic_server = true,
		publish_diagnostic_on = "insert_leave",
		expose_as_code_action = { "add_missing_imports", "remove_unused_imports" },
		tsserver_max_memory = "auto",
		tsserver_file_preferences = {
			quotePreference = "double",
			includeCompletionsForModuleExports = true,
			includeCompletionsForImportStatements = true,
			importModuleSpecifierEnding = "index",
		},
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

lspconfig.rust_analyzer.setup({
	settings = {
		["rust-analyzer"] = {
			cargo = {
				allFeatures = true,
			},
			imports = {
				group = {
					enable = false,
				},
			},
			completion = {
				postfix = {
					enable = false,
				},
			},
		},
	},
})

local servers = {
	"clangd",
	"prismals",
	"pyright",
}

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		handlers = handlers,
		capabilities = capabilities(),
	})
end
