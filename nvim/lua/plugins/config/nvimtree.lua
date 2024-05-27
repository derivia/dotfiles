local status_ok, plugin = pcall(require, "nvim-tree")
if not status_ok then
	vim.notify("plugin " .. plugin .. " failed to start.")
	return
end

plugin.setup({
	select_prompts = true,
	git = {
		enable = false,
	},
	renderer = {
		indent_width = 1,
		indent_markers = {
			enable = true,
			inline_arrows = false,
		},
		icons = {
			web_devicons = {
				file = {
					color = true,
				},
				folder = {
					color = false,
				},
			},
		},
	},
})
