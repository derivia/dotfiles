local status_ok_lspconfig, lspconfig = pcall(require, "lspconfig")
local status_ok_blinkcmp, blink_cmp = pcall(require, "blink.cmp")

if not status_ok_lspconfig or not status_ok_blinkcmp then
	vim.notify("Something went wrong with LSP startup.")
	return
end

local methods = vim.lsp.protocol.Methods

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

	-- Set diagnostics config per client
	vim.diagnostic.config({
		underline = true,
		signs = {
			severity = {
				vim.diagnostic.severity.INFO,
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
	}, vim.lsp.diagnostic.get_namespace(client.id))
end

local capabilities = function()
	local default_capabilities = vim.lsp.protocol.make_client_capabilities()
	local blink_capabilities = blink_cmp.get_lsp_capabilities()
	return vim.tbl_deep_extend("force", default_capabilities, blink_capabilities)
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
				globals = { "vim" },
			},
		},
	},
})

lspconfig.clangd.setup({
	cmd = {
		"clangd",
		"--clang-tidy",
	},
	on_attach = on_attach,
	handlers = handlers,
	capabilities = capabilities(),
})

local servers = {
	"pyright",
	"rust_analyzer",
	"ts_ls", -- typescript language server [no vue support]
}

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		handlers = handlers,
		capabilities = capabilities(),
	})
end
