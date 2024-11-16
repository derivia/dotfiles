local status_ok_kanagawa, kanagawa = pcall(require, "kanagawa")
local status_ok_catppuccin, catppuccin = pcall(require, "catppuccin")
if not status_ok_kanagawa or not status_ok_catppuccin then
	vim.notify("colorschemes failed to start")
	return
end

kanagawa.setup({
	compile = false,
	undercurl = false,
	commentStyle = { italic = false },
	functionStyle = {},
	keywordStyle = { italic = false },
	statementStyle = { bold = true },
	typeStyle = {},
	transparent = false,
	dimInactive = false,
	terminalColors = true,
	background = {
		dark = "wave",
		light = "lotus",
	},
	colors = {
		palette = {
			sumiInk3 = "#25252B",
			sakuraPink = "#E29066",
			oniViolet = "#C07FA1",
			crystalBlue = "#98BFFA",
			springBlue = "#98BFFA",
			fujiGray = "#858585",
		},
	},
})

catppuccin.setup({
	flavour = "frappe",
	background = {
		light = "latte",
		dark = "frappe",
	},
	no_italic = true,
	no_bold = true,
	no_underline = false,
})

pcall(vim.cmd.colorscheme, "kanagawa")
