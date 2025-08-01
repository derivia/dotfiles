-- load options and keymaps before plugins
vim.g.start_time = vim.fn.reltime()
vim.loader.enable() -- experimental setting for faster behaviour
require("config.opts")
require("config.keys")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
-- require modular plugin configuration after starting lazy.nvim
require("config.lazy")
