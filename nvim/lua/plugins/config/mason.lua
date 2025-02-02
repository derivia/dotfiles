local status_ok_mason, mason = pcall(require, "mason")
local status_ok_masontools, masontools = pcall(require, "mason-tool-installer")

if not status_ok_mason and status_ok_masontools then
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
		"clangd",
		"lua-language-server",
		"jedi-language-server",
		"pyright",
		"typescript-language-server",
		{ "rust-analyzer", version = "2024-10-21" },

		-- formatter
		"black",
		"biome",
		"clang-format",
		"stylua",
		-- rustfmt should be installed via rustup
		"prettierd",
		"standardrb",
		"yamlfmt",
	},
	run_on_start = true,
	start_delay = 128,
})
