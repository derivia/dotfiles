local status_ok, plugin = pcall(require, "luasnip")

if not status_ok then
	return
end

local snippetDir = vim.fn.stdpath("config") .. "/snippets"

plugin.filetype_extend("javascriptreact", { "html" })
plugin.filetype_extend("typescriptreact", { "html" })

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({ paths = { snippetDir } })

