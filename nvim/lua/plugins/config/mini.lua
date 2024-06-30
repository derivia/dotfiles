local status_ok_bufremove, bufremove = pcall(require, "mini.bufremove")

if not status_ok_bufremove then
	return
end

bufremove.setup()
