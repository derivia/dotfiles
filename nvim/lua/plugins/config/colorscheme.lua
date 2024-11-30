local colorscheme = "opera"

local status_ok_applied, colorscheme_applied = pcall(vim.cmd.colorscheme, colorscheme)
if not status_ok_applied then
	vim.notify(string.format("failed to apply %s", colorscheme_applied))
	return
end
