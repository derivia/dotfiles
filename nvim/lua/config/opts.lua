local o = vim.opt
local g = vim.g

-- map leader to space
g.mapleader = " "
g.mapolocalleader = " "

-- dark theme
o.background = "dark"
-- disable backup
o.backup = false
-- height of command line
o.cmdheight = 1
-- completion menu options
o.completeopt = { "menuone", "noselect" }
-- disable hidden text
o.conceallevel = 0
-- remove cursor column and line background
o.cursorcolumn = false
o.cursorline = false
-- use tab as spaces
o.expandtab = true
-- default to uft-8
o.fileencoding = "utf-8"
-- hide buffers instead of abandoning them
o.hidden = true
-- disable search result highlighting 
o.hlsearch = false
-- case-insensitive search
o.ignorecase = true
-- show results of incremental substitution and other things
o.inccommand = "split"
o.incsearch = true
-- show status bar only on focused window
o.laststatus = 1
-- enable mouse everywhere
o.mouse = "a"
-- show number lines
o.number = true
o.numberwidth = 2
-- popup menu maximum number of items
o.pumheight = 5
-- relative numbering lines
o.relativenumber = true
-- keep cursor kind of centered vertically
o.scrolloff = 8
-- configure the shared data file
o.shada = "'1000,<50,s25,h"
-- default to two spaces
o.shiftwidth = 2
-- disable intro message
o.shortmess:append({ I = true })
-- don't show mode
o.showmode = false
-- keep cursor kind of centered horizontally
o.sidescrolloff = 2
-- space for symbols left to the numbers
o.signcolumn = "yes"
-- case sensitive if search has uppercases
o.smartcase = true
-- smart indentation
o.smartindent = true
-- enable splits (i guess)
o.splitbelow = true
o.splitright = true
-- disable swap file
o.swapfile = false
-- default tab to 2
o.tabstop = 2
-- enable 24-bit RGB color
o.termguicolors = true
-- 400ms timeout for key combinations
o.timeoutlen = 400
-- remember undo when buffer is abandoned
o.undofile = true
-- faster updatetime
o.updatetime = 500
-- add one virtual character more to the right
o.virtualedit = "onemore"
-- disable visual wrapping
o.whichwrap:remove({ "w", "b", "h", "l" })
o.wrap = false
-- disable backup writing
o.writebackup = false
