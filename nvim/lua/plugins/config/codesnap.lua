local status_ok, plugin = pcall(require, "codesnap")
if not status_ok then
	return
end

plugin.setup({
	bg_color = "#232323",
	bg_padding = 2,
	code_font_family = "RobotoMono Nerd Font",
	has_breadcrumbs = false,
	has_line_number = true,
	mac_window_bar = false,
	save_path = "~/snaps",
	title = "",
	watermark = "",
})
