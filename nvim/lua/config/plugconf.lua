local plugins = "config.options."

-- load colorscheme first
local status_colorscheme, _ = pcall(require, plugins .. "colorscheme")
if not status_colorscheme then
	vim.notify("colorscheme failed to load")
end

local plug_list = {
	"colorizer",
  "lsp",
	"lualine",
	"mason",
	"mkdnflow",
	"nvimtree",
	"treesitter",
}

for _, plugin in ipairs(plug_list) do
	local status_ok, _ = pcall(require, plugins .. plugin)
	if not status_ok then
		vim.notify("plugin `" .. plugin .. "` failed to start")
	end
end
