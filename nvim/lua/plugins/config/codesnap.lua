local status_ok, plugin = pcall(require, "codesnap")
if not status_ok then
	return
end

plugin.setup({
	save_path = "~/snaps",
	has_breadcrumbs = false,
	bg_color = "#232323",
	title = "",
	watermark = "",
	has_line_number = true,
  bg_padding = 0,
  mac_window_bar = false,
})
