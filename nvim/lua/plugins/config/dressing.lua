local status_ok, plugin = pcall(require, "dressing")
if not status_ok then
	return
end

plugin.setup({
	input = {
		enabled = true,
		default_prompt = "Input",
		trim_prompt = true,
		title_pos = "left",
		start_in_insert = true,
		border = "rounded",
		relative = "cursor",
		prefer_width = 40,
		width = nil,
		max_width = { 140, 0.9 },
		min_width = { 20, 0.2 },
		buf_options = {},
		win_options = {
			wrap = false,
			list = true,
			listchars = "precedes:…,extends:…",
			sidescrolloff = 0,
		},
		mappings = {
			n = {
				["<Esc>"] = "Close",
				["<CR>"] = "Confirm",
			},
			i = {
				["<C-c>"] = "Close",
				["<CR>"] = "Confirm",
				["<Up>"] = "HistoryPrev",
				["<Down>"] = "HistoryNext",
			},
		},
	},
	select = {
		enabled = true,
		backend = { "fzf_lua", "fzf", "builtin", "nui" },
		trim_prompt = true,
		fzf_lua = {},
		format_item_override = {},
		get_config = nil,
	},
})
