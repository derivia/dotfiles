local status_ok, plugin = pcall(require, "telescope")
if not status_ok then
	return
end

plugin.setup({
	border = true,
	defaults = {
		history = {
			limit = 1000,
		},
	},
	pickers = {
		find_files = {
			hidden = false,
		},
		colorscheme = {
			enable_preview = true,
		},
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},
})

plugin.load_extension("ui-select")
plugin.load_extension("fzf")
