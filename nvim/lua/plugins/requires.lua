local config = "plugins.config."

local plugins = {
	"cmp",
	"colorizer",
	"comment",
	"dressing",
	"formatter",
	"fzf",
	"lsp",
	"lualine",
	"luasnip",
	"mason",
	"mkdnflow",
	"nvimtree",
	"treesitter",
}

-- load colorscheme first
pcall(require, config .. "colorscheme")

for _, plugin in ipairs(plugins) do
	local status_ok, _ = pcall(require, config .. plugin)
	if not status_ok then
		vim.notify("plugin [" .. plugin .. "] failed to start")
	end
end
