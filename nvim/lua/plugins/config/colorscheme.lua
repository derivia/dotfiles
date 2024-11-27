local status_ok, plugin = pcall(require, "kanagawa")
if not status_ok then
	vim.notify("colorschemes failed to start")
	return
end

plugin.setup({
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

local colorscheme = "kanagawa"

local status_ok_applied, colorscheme_applied = pcall(vim.cmd.colorscheme, colorscheme)
if not status_ok_applied then
	vim.notify(string.format("failed to apply %s", colorscheme_applied))
	return
end
