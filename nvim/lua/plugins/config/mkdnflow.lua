local status_ok, plugin = pcall(require, "mkdnflow")
if not status_ok then
	vim.notify("plugin" .. plugin .. "failed to start")
	return
end

plugin.setup({
	modules = {
		bib = true,
		buffers = true,
		conceal = false,
		cursor = true,
		folds = false,
		links = true,
		lists = true,
		maps = true,
		paths = true,
		tables = false,
		yaml = false,
		cmp = false,
	},
})
