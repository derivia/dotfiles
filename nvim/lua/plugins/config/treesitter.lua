local status_ok, plugin = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

plugin.setup({
	highlight = {
		enable = true,
		disable = { "markdown", "txt", "git" },
		additional_vim_regex_highlighting = false,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<leader>vn",
			node_incremental = "<leader>vr",
			scope_incremental = "<leader>vc",
			node_decremental = "<leader>vm",
		},
	},
	ensure_installed = {
		"c",
		"java",
		"javascript",
		"json",
		"lua",
		"markdown",
		"markdown_inline",
		"python",
		"query",
		"ruby",
		"rust",
		"tsx",
		"typescript",
		"vim",
		"vimdoc",
	},
	sync_install = false,
	auto_install = false,
})
