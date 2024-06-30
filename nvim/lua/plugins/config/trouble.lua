local status_ok, plugin = pcall(require, "trouble")
if not status_ok then
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
	icons = {
		indent = {
			middle = " ",
			last = " ",
			top = " ",
			ws = "│  ",
		},
	},
	preview = {
		type = "main",
		scratch = true,
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
