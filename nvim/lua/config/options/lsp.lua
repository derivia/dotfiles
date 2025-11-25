local methods = vim.lsp.protocol.Methods
local status_ok_blinkcmp, blink_cmp = pcall(require, "blink.cmp")

if not status_ok_blinkcmp then
	vim.notify("Blinkcmp 'require' failed on lsp configuration.")
	return
end

local handlers = {
	["textDocument/hover"] = function(_, result, ctx, config)
		config = config or { border = "rounded" }
		if not (result and result.contents) then
			return
		end
		vim.lsp.util.focusable_float(ctx.bufnr, function()
			return vim.lsp.util.open_floating_preview(
				vim.lsp.util.convert_input_to_markdown_lines(result.contents),
				"markdown",
				config
			)
		end)
	end,
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
		keymap("<leader>lrn", "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename symbol", { "n", "x" })
	end
	if client.supports_method(methods.textDocument_declaration) then
		keymap("gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", "Go to declaration", "n")
	end
	if client.supports_method(methods.textDocument_implementation) then
		keymap("gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", "Go to implementation", "n")
	end
	if client.supports_method(methods.textDocument_codeAction) then
		keymap("<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code actions", { "n", "x" })
	end
	if client.supports_method(methods.textDocument_references) then
		keymap("gr", "<cmd>lua vim.lsp.buf.references()<CR>", "See usage (references)", { "n", "x" })
	end
	vim.diagnostic.config({
		underline = true,
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = "X",
				[vim.diagnostic.severity.WARN] = "",
				[vim.diagnostic.severity.INFO] = "",
				[vim.diagnostic.severity.HINT] = "",
			},
			update_in_insert = false,
			severity_sort = true,
		},
	}, vim.lsp.diagnostic.get_namespace(client.id))
end

local capabilities = function()
	local default_capabilities = vim.lsp.protocol.make_client_capabilities()
	local blink_capabilities = blink_cmp.get_lsp_capabilities()
	return vim.tbl_deep_extend("force", default_capabilities, blink_capabilities)
end

require("lspconfig.ui.windows").default_options.border = "rounded"

vim.lsp.config("lua_ls", {
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
				globals = { "vim" },
			},
		},
	},
})

vim.lsp.config("clangd", {
	on_attach = on_attach,
	handlers = handlers,
	capabilities = capabilities(),
	filetypes = { "c" },
})

vim.lsp.config("solargraph", {
	on_attach = on_attach,
	handlers = handlers,
	capabilities = capabilities(),
	single_file_support = true,
	init_options = {
		formatting = false,
	},
	settings = {
		solargraph = {
			diagnostics = {
				rubocop = {
					configFile = vim.fn.expand("~") .. "/.rubocop.yml",
				},
			},
		},
	},
})

vim.lsp.config("emmet_ls", {
	on_attach = on_attach,
	handlers = handlers,
	capabilities = capabilities(),
	filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "vue" },
})

vim.lsp.config("angularls", {
	on_attach = on_attach,
	handlers = handlers,
	capabilities = capabilities(),
	filetypes = { "htmlangular" },
})

vim.lsp.config("ts_ls", {
	on_attach = on_attach,
	handlers = handlers,
	capabilities = capabilities(),
	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
})

vim.lsp.config("cssls", {
	on_attach = on_attach,
	handlers = handlers,
	capabilities = capabilities(),
	filetypes = { "css", "scss", "less" },
})

vim.lsp.config("pyright", {
	on_attach = on_attach,
	handlers = handlers,
	capabilities = capabilities(),
	filetypes = { "python" },
})

vim.lsp.config("rust_analyzer", {
	on_attach = on_attach,
	handlers = handlers,
	capabilities = capabilities(),
	filetypes = { "rust" },
})

local enabled_servers = {
	"lua_ls",
	"clangd",
	"solargraph",
	"emmet_ls",
	"cssls",
	"pyright",
	"angularls",
	"rust_analyzer",
	"ts_ls",
}

for _, server in ipairs(enabled_servers) do
	vim.lsp.enable({ server })
end
