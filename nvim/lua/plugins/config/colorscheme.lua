local status_ok, kanagawa = pcall(require, "kanagawa")
if not status_ok then
	vim.notify("plugin" .. kanagawa .. "failed to start")
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

pcall(vim.cmd.colorscheme, "kanagawa")
