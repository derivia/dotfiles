local status_ok, plugin = pcall(require, "toggleterm")
if not status_ok then
	return
end

plugin.setup({
	on_create = function()
		vim.cmd([[ setlocal signcolumn=no ]])
	end,
	open_mapping = [[<C-\>]],
	direction = "horizontal",
	hide_numbers = true,
	shade_filetypes = {},
	autochdir = false,
	shade_terminals = true,
	start_in_insert = true,
	insert_mappings = true,
	terminal_mappings = true,
	persist_size = true,
	close_on_exit = true,
	auto_scroll = true,
})

function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
	-- going in and out of terminals
	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
	vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
