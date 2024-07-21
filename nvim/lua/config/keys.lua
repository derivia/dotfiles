-- shorter default options
local opts = { noremap = true, silent = true }
-- shorter function name
local keymap = vim.api.nvim_set_keymap

-- space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.mapolocalleader = " "

-- unmapping some keys
keymap("", "<leader>lo", "<Nop>", opts)
keymap("", "<leader>la", "<Nop>", opts)
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

-- buffer navigation
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

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

-- nvimtree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- format file using formatter.nvim
keymap("n", "<C-f>", ":Format<CR>", opts)

-- makes so $ goes one more after the last character
keymap("n", "$", "$l", opts)
-- but one less when visual mode
keymap("v", "$", "$h", opts)
keymap("x", "$", "$h", opts)

if vim.fn.getenv("WSLENV") ~= vim.NIL then
	vim.keymap.set("n", "gx", ":silent :execute '!wslview ' . shellescape(expand('<cfile>'), 1)<CR>", opts)
end

-- stylua: ignore start
-- open man pages on new windows
keymap("n", "<C-m>l", ':execute "vsp | wincmd l | hide Man " . input("section number: ") . " " . input("page name: ")<CR>', opts)
keymap("n", "<C-m>j", ':execute "sp | wincmd j | hide Man " . input("section number: ") . " " . input("page name: ")<CR>', opts)
-- stylua: ignore end

-- trouble configuration
keymap("n", "<leader>xx", ":Trouble diagnostics toggle<CR>", opts)

-- telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fo", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>fr", ":Telescope oldfiles<CR>", opts)

-- stylua: ignore start
-- scissors configuration
vim.keymap.set("n", "<leader>se", function() require("scissors").editSnippet() end, opts)
vim.keymap.set({ "n", "x" }, "<leader>sa", function() require("scissors").addNewSnippet() end, opts)
-- stylua: ignore end

-- close tab and go to another buffer, if there's one.
local status_ok_br, br = pcall(require, "mini.bufremove")
if not status_ok_br then
	return
end

-- inc-rename configuration
-- vim.keymap.set("n", "<leader>rn", function()
--   return ":IncRename " .. vim.fn.expand("<cword>")
-- end, { expr = true })

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
