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
		"prisma-language-server",
		"rust-analyzer",
		"python-lsp-server",
		"typescript-language-server",
		"pyright",

		-- formatter
		"black",
		"clang-format",
		"stylua",
		-- rustfmt should be installed via rustup
		"prettierd",
		"standardrb",
	},
	run_on_start = true,
	start_delay = 128,
})
