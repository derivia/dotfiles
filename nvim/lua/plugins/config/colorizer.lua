local status_ok, plugin = pcall(require, "colorizer")
if not status_ok then
	vim.notify("plugin" .. plugin .. "failed to start")
	return
end

plugin.setup({
	"css",
	"javascript",
	"javascriptreact",
	"lua",
	"typescript",
	"typescriptreact",
})
