local status_ok, plugin = pcall(require, "mkdnflow")
if not status_ok then
	vim.notify("plugin" .. plugin .. "failed to start")
	return
end

-- @TODO: configure mkdnflow
plugin.setup({})
