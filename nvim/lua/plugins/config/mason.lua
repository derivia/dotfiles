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
		-- Angular
		"angular-language-server", -- LSP

		-- C/C++
		"clangd", -- lsp
		"clang-format", -- formatter

		-- Lua
		"lua-language-server", -- lsp
		"stylua", -- formatter

		-- Javascript
		"prettierd", -- formatter
		"typescript-language-server", -- lsp
		"prisma-language-server", -- prisma lsp

		-- HTML
		"html-lsp", -- lsp

		-- Ruby
		"solargraph", -- lsp
		"standardrb", -- formatter

		-- Rust
		"rust-analyzer", -- lsp
	},
	run_on_start = true,
	start_delay = 256,
})
