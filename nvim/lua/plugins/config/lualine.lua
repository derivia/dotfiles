local status_ok, plugin = pcall(require, "lualine")

if not status_ok then
	return
end

local filetype = {
	"filetype",
	icons_enabled = true,
	padding = 1,
}

plugin.setup({
	options = {
    theme = "oxocarbon",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
		disabled_filetypes = { "alpha", "NvimTree" },
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "" },
		lualine_c = { "filename" },
		lualine_x = { "" },
		lualine_y = { "encoding" },
		lualine_z = { filetype },
	},
})
