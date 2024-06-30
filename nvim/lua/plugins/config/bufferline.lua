local status_ok, plugin = pcall(require, "bufferline")
if not status_ok then
	return
end

plugin.setup({
	options = {
		custom_filter = function(buf_number)
			if vim.bo[buf_number].filetype ~= "NvimTree" or vim.bo[buf_number].filetype ~= "alpha" then
				return true
			end
			if vim.fn.bufname(buf_number) ~= "[No Name]" then
				return true
			end
		end,
		offsets = {
			{
				filetype = "NvimTree",
				text = "File explorer",
				separator = false,
			},
		},
		always_show_bufferline = false,
		show_buffer_icons = false,
		show_close_icon = false,
		tab_size = 18,
		diagnostics = false,
	},
})
