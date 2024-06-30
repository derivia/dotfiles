local opt = vim.opt

-- disabling netwr in order to use NvimTree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- disables backup
opt.backup = false
-- don't abandon buffers
opt.hidden = true
-- makes so `` appears on markdown files
opt.conceallevel = 0
-- treats the tab completiom menu
opt.completeopt = { "menuone", "noselect" }
-- sets the default encoding to utf-8
opt.fileencoding = "utf-8"
-- highlights matches on search pattern
opt.hlsearch = true
-- moving while searching
opt.incsearch = true
-- enables the mouse everywhere
opt.mouse = "a"
-- disables the mode showing at the status bar
opt.showmode = false
-- smarter case insensitivity/sensitivity
opt.smartcase = true
-- case-insensitive search/replace
opt.ignorecase = true
-- always draw signcolumn on the left
opt.signcolumn = "yes"
-- maximum number of items to show on popups
opt.pumheight = 15
-- changes the size of the cmdheight below the lualine
opt.cmdheight = 1
-- makes indenting smarter (i guess)
opt.smartindent = true
-- makes splitted windows to be kept on the current window
opt.splitbelow = true
opt.splitright = true
-- disables swap file creation
opt.swapfile = false
-- makes so the update time is faster, for a faster <TAB> completion
opt.updatetime = 100
-- converts tabs to spaces
opt.expandtab = true
-- some colors
opt.termguicolors = true
-- sets the default tab (as spaces) size
opt.shiftwidth = 2
opt.tabstop = 2
-- highlights the current line
opt.cursorline = true
-- show current line number
opt.number = true
-- show other lines than current relative numbered
opt.relativenumber = true
-- disables wrapping
opt.wrap = false
-- stop h and l from going up/down the line when line beginning/end was reached
opt.whichwrap:remove({ "w", "b", "h", "l" })
-- makes the cursor go one more at the end of the line
opt.virtualedit = "onemore"
-- removes horizontally splitted windows status line
opt.laststatus = 0
-- disable intro message
opt.shortmess:append({ I = true })
