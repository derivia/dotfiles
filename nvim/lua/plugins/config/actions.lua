local status_ok, plugin = pcall(require, "actions-preview")
if not status_ok then
	vim.notify("plugin " .. plugin .. " failed to start.")
	return
end

plugin.setup({
	diff = {
		algorithm = "patience",
		ignore_whitespace = true,
		ctxlen = 3,
	},
	backend = { "telescope" },
	telescope = {
		sorting_strategy = "ascending",
		layout_strategy = "vertical",
		layout_config = {
			width = 0.8,
			height = 0.9,
			prompt_position = "top",
			preview_cutoff = 15,
			preview_height = function(_, _, max_lines)
				return max_lines - 12
			end,
		},
	},
})