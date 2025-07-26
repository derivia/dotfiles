local status_ok, plugin = pcall(require, "lualine")

if not status_ok then
	return
end

local filetype = {
	"filetype",
	icons_enabled = true,
	padding = 1,
}
local filename = { "filename", path = 1 }
local diagnostics = { "diagnostics", always_visible = true }
local lsp_status = { "lsp_status", icon = "", ignore_lsp = { "copilot" } }

plugin.setup({
	options = {
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		refresh = {
			statusline = 100,
			tabline = 100,
			winbar = 100,
		},
		disabled_filetypes = { "alpha", "NvimTree" },
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { diagnostics },
		lualine_c = { filename },
		lualine_x = { lsp_status },
		lualine_y = { "encoding" },
		lualine_z = { filetype },
	},
})
