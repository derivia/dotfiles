local status_ok_kanagawa, kanagawa = pcall(require, "kanagawa")

if not status_ok_kanagawa then
	vim.notify("plugin " .. kanagawa .. "failed to start")
	return
end

kanagawa.setup({
	compile = false,
	undercurl = false,
	commentStyle = { italic = false },
	functionStyle = {},
	keywordStyle = { italic = false },
	statementStyle = { bold = false },
	typeStyle = {},
	transparent = false,
	dimInactive = false,
	terminalColors = true,
	colors = {
		palette = {
			-- darker background
			sumiInk0 = "#12121A",
			sumiInk1 = "#151516",
			sumiInk2 = "#1A1A22",
			sumiInk3 = "#1D1D28",
			sumiInk4 = "#2A2A44",
			sumiInk5 = "#2C2C44",
			fujiGray = "#929994",
		},
		-- askdoaowkdoakw
		theme = { wave = {} },
	},
	overrides = function(colors)
		return {}
	end,
})

vim.cmd("colorscheme kanagawa")
