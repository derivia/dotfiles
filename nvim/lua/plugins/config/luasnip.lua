local status_ok, plugin = pcall(require, "luasnip")
if not status_ok then
	vim.notify("plugin " .. plugin .. " failed to start.")
	return
end

local snippetDir = vim.fn.stdpath("config") .. "/snippets"
require("luasnip.loaders.from_vscode").lazy_load( { paths = { snippetDir } })
