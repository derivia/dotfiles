local status_ok, plugin = pcall(require, "nvim-tree")
if not status_ok then
	return
end

local function own_on_attach(bufnr)
	local api = require("nvim-tree.api")
	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- default mappings
	api.config.mappings.default_on_attach(bufnr)
	-- custom mappings
	vim.keymap.set("n", "<C-t>", api.tree.change_root_to_node, opts("CD"))
	vim.keymap.set("n", "<leader><C-l>", api.node.open.vertical, opts("Open: Vertical Split"))
	vim.keymap.set("n", "<leader><C-j>", api.node.open.horizontal, opts("Open: Horizontal Split"))
end

plugin.setup({
	on_attach = own_on_attach,
	select_prompts = true,
	git = {
		enable = false,
	},
	view = {
		signcolumn = "no",
	},
	renderer = {
		indent_width = 2,
		indent_markers = {
			enable = true,
			inline_arrows = true,
		},
		icons = {
			web_devicons = {
				file = {
					color = true,
				},
				folder = {
					color = false,
				},
			},
			show = {
				folder_arrow = true,
			},
		},
	},
})
