local status_ok, plugin = pcall(require, "luasnip")
if not status_ok then
	vim.notify("plugin " .. plugin .. " failed to start.")
	return
end

local snippetDir = vim.fn.stdpath("config") .. "/snippets"

plugin.filetype_extend("javascript", { "javascriptreact" })
plugin.filetype_extend("javascript", { "html" })
plugin.filetype_extend("typescript", { "typescriptreact" })
plugin.filetype_extend("typescript", { "html" })

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({ paths = { snippetDir } })
