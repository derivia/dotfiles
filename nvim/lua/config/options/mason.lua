local status_ok_mason, mason = pcall(require, "mason")
local status_ok_masontools, masontools = pcall(require, "mason-tool-installer")

if not status_ok_mason or not status_ok_masontools then
	return
end

mason.setup({
	ui = {
		border = "rounded",
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

masontools.setup({
	ensure_installed = {
		-- lsp
		"angular-language-server",
		"clangd",
		-- "java-language-server",
		"lua-language-server",
		"pyright",
		"rust-analyzer",
		"solargraph",
		"typescript-language-server",
		"emmet-ls",

		-- formatter
		"beautysh",
		"biome",
		"black",
		"clang-format",
		"htmlbeautifier",
		"nginx-config-formatter",
		"prettierd",
		"rubocop",
		"stylua",
		"yamlfmt",
	},
	run_on_start = true,
	start_delay = 128,
})
