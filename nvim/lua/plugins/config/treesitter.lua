local status_ok, plugin = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	vim.notify("plugin" .. plugin .. "failed to start")
	return
end

plugin.setup({
	ensure_installed = {
		"c",
		"javascript",
		"lua",
		"markdown",
		"markdown_inline",
		"query",
		"rust",
		"typescript",
		"vim",
		"vimdoc",
	},
	sync_install = false,
	auto_install = false,
	ignore_install = {},
	highlight = {
		enable = true,
		disable = { "markdown" },
		additional_vim_regex_highlighting = false,
	},
})
