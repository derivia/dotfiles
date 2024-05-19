local status_ok, plugin = pcall(require, "nvim-tree")
if not status_ok then
	vim.notify("plugin " .. plugin .. " failed to start.")
	return
end

plugin.setup({
	git = {
		enable = false,
	},
})