local config = "plugins.config."

-- load colorscheme first
pcall(require, config .. "colorscheme")

local plugins = {
	"cmp",
	"codesnap",
	"colorizer",
	"lsp",
	"lualine",
	"luasnip",
	"mason",
	"mkdnflow",
	"nvimtree",
	"project",
	"treesitter",
}

for _, plugin in ipairs(plugins) do
	local status_ok, _ = pcall(require, config .. plugin)
	if not status_ok then
		vim.notify("plugin [" .. plugin .. "] failed to start")
	end
end
