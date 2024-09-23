-- shorter default options
local opts = { noremap = true, silent = true }
-- shorter function name
local keymap = vim.api.nvim_set_keymap

-- space as leader key
keymap("", "<Space>", "<Nop>", opts)

-- unmapping some keys
keymap("", "<C-q>", "<Nop>", opts)
keymap("", "<C-c>", "<Nop>", opts)
keymap("", "<C-y>", "<Nop>", opts)
keymap("", "<C-d>", "<Nop>", opts)
keymap("", "<S-j>", "<Nop>", opts)

-- center search results
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)

-- to move windows around
-- <C-w><shift-direction>
-- as example: <C-w>L
-- moves the current focused window to the right

-- window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- resize the current window
keymap("n", "<S-Up>", ":resize +2<CR>", opts)
keymap("n", "<S-Down>", ":resize -2<CR>", opts)
keymap("n", "<S-Left>", ":vertical resize +2<CR>", opts)
keymap("n", "<S-Right>", ":vertical resize -2<CR>", opts)

-- clear highlights
keymap("n", "<leader>h", ":noh<CR>", opts)

-- move lines
-- normal mode
keymap("n", "<A-j>", ":m+1<CR>", opts)
keymap("n", "<A-k>", ":m-2<CR>", opts)
keymap("n", "<A-h>", "<<", opts)
keymap("n", "<A-l>", ">>", opts)
-- visual block mode
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-h>", "<gv", opts)
keymap("x", "<A-l>", ">gv", opts)

-- makes I still enter current position in insert mode
keymap("n", "I", "i", opts)

-- makes so $ goes one more after the last character
keymap("n", "$", "$l", opts)
-- but one less when visual mode
keymap("v", "$", "$h", opts)
keymap("x", "$", "$h", opts)

if vim.fn.getenv("WSLENV") ~= vim.NIL then
	vim.keymap.set("n", "gx", ":silent :execute '!wslview ' . shellescape(expand('<cfile>'), 1)<CR>", opts)
end

-- close tab and go to another buffer, if there's one.
local status_ok_br, br = pcall(require, "mini.bufremove")
if not status_ok_br then
	return
end
-- stylua: ignore start
-- code from LazyVim.editor.lua
vim.keymap.set("n", "<C-x>", function()
	if vim.bo.modified then
		local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
		if choice == 1 then -- Yes
			vim.cmd.write()
			br.delete(0)
		elseif choice == 2 then -- No
			br.delete(0, true)
		end
	else
		br.delete(0)
	end
end, opts)
-- stylua: ignore end
