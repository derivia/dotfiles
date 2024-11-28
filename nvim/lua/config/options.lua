local o = vim.opt
local g = vim.g

g.mapleader = " "
g.mapolocalleader = " "

-- disables backup
o.backup = false
-- don't save when switching buffers
o.hidden = true
-- makes so `` appears on markdown files
o.conceallevel = 0
-- treats the tab completiom menu
o.completeopt = { "menuone", "noselect" }
-- sets the default encoding to utf-8
o.fileencoding = "utf-8"
-- highlights matches on search pattern
o.hlsearch = true
-- moving while searching
o.incsearch = true
-- enables the mouse
o.mouse = "a"
-- disables the mode showing at the status bar
o.showmode = false
-- smarter case insensitivity/sensitivity
o.smartcase = true
-- case-insensitive search/replace
o.ignorecase = true
-- always draw signcolumn
o.signcolumn = "yes"
-- maximum number of items to show on popups
o.pumheight = 15
-- changes the size of the cmdheight below the lualine
o.cmdheight = 1
-- makes indenting smarter (i guess)
o.smartindent = true
-- makes splitted windows to be kept on the current window
o.splitbelow = true
o.splitright = true
-- disables swap file creation
o.swapfile = false
-- makes so the update time is faster, for a faster <TAB> completion
o.timeoutlen = 500
o.updatetime = 200
-- converts tabs to spaces
o.expandtab = true
-- some colors
o.termguicolors = true
-- sets the default tab (as spaces) size
o.shiftwidth = 2
o.tabstop = 2
-- don't highlight the current line
o.cursorline = false
-- line numbers
o.number = true
o.numberwidth = 2
o.relativenumber = true
-- disables wrapping
o.wrap = false
-- smooth scrooling
o.smoothscroll = true
-- stop h and l from going up/down the line when line beginning/end was reached
o.whichwrap:remove({ "w", "b", "h", "l" })
-- makes the cursor go one more at the end of the line
o.virtualedit = "onemore"
-- removes horizontally splitted windows status line
o.laststatus = 3
-- disable intro message
o.shortmess:append({ I = true })
-- keep the cursor kinda centralized
o.scrolloff = 8
o.sidescrolloff = 2

-- disable health checks for these providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
