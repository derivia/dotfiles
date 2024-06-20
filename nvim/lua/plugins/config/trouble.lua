local status_ok, plugin = pcall(require, "trouble")
if not status_ok then
	vim.notify("plugin " .. plugin .. " failed to start.")
	return
end

plugin.setup({
	warn_no_results = false,
	open_no_results = true,
	follow = false,
	focus = true,
	indent_guides = false,
	max_items = 200,
	multiline = true,
	preview = {
		type = "main",
		scratch = true,
	},
	icons = {
		indent = {
			middle = " ",
			last = " ",
			top = " ",
			ws = "│  ",
		},
	},
	modes = {
		diagnostics = {
			groups = {
				{ "filename", format = "{file_icon} {basename:Title} {count}" },
			},
		},
		diagnostics_buffer = {
			mode = "diagnostics",
			filter = { buf = 0 },
		},
	},
})
