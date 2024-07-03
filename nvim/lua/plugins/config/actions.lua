local status_ok, plugin = pcall(require, "actions-preview")
if not status_ok then
	vim.notify("plugin" .. plugin .. "failed to start")
	return
end

plugin.setup({
	diff = {
		ctxlen = 3,
	},
	highlight_command = {
		require("actions-preview.highlight").delta(),
		-- require("actions-preview.highlight").diff_so_fancy(),
		-- require("actions-preview.highlight").diff_highlight(),
	},
	backend = { "telescope" },
	telescope = vim.tbl_extend("force", require("telescope.themes").get_dropdown(), {
		make_value = nil,
		make_make_display = nil,
	}),
})
