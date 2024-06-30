local status_ok, plugin = pcall(require, "Comment")
if not status_ok then
	return
end

plugin.setup({
	pre_hook = function()
		return vim.bo.commentstring
	end,
})
