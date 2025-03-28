local status_ok, plugin = pcall(require, "project_nvim")
if not status_ok then
	return
end

plugin.setup({
	manual_mode = true,
	detection_methods = { "lsp", "pattern" },
	patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
	ignore_lsp = {},
	show_hidden = false,
	silent_chdir = true,
	scope_chdir = "global",
	datapath = vim.fn.stdpath("data"),
})
