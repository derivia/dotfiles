-- disabling netwr in order to use NvimTree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- disables backup
vim.opt.backup = false
-- don't abandon buffers
vim.opt.hidden = true
-- makes so `` appears on markdown files
vim.opt.conceallevel = 0
-- treats the tab completiom menu
vim.opt.completeopt = { "menuone", "noselect" }
-- sets the default encoding to utf-8
vim.opt.fileencoding = "utf-8"
-- highlights matches on search pattern
vim.opt.hlsearch = true
-- disables moving while searching
vim.opt.incsearch = false
-- enables the mouse everywhere
vim.opt.mouse = "a"
-- disables the mode showing at the status bar
vim.opt.showmode = false
-- smarter case insensitivity/sensitivity
vim.opt.smartcase = true
-- case-insensitive search/replace
vim.opt.ignorecase = true
-- always draw signcolumn on the left
vim.opt.signcolumn = "yes"
-- maximum number of items to show on popups
vim.opt.pumheight = 10
-- changes the size of the cmdheight below the lualine
vim.opt.cmdheight = 1
-- makes indenting smarter (i guess)
vim.opt.smartindent = true
-- makes splitted windows to be kept on the current window
vim.opt.splitbelow = true
vim.opt.splitright = true
-- disables swap file creation
vim.opt.swapfile = false
-- makes so the update time is faster, for a faster <TAB> completion
vim.opt.updatetime = 100
-- converts tabs to spaces
vim.opt.expandtab = true
-- some colors
vim.opt.termguicolors = true
-- sets the default tab (as spaces) size
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
-- highlights the current line
vim.opt.cursorline = true
-- show relative numbers and real line numbers
vim.opt.number = true
vim.opt.relativenumber = true
-- disables wrapping
vim.opt.wrap = false
-- stop h and l from going up/down the line when line beginning/end was reached
vim.opt.whichwrap:remove({ "w", "b", "h", "l" })
-- makes the cursor go one more at the end of the line
vim.opt.virtualedit = "onemore"
-- removes horizontally splitted windows status line
vim.opt.laststatus = 0
-- disable intro message
vim.opt.shortmess:append("I")
