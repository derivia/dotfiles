---@diagnostic disable: undefined-field

-- shorter default options
local opts = { noremap = true, silent = true }
-- shorter function name
local keymap = vim.api.nvim_set_keymap

-- space as leader key
keymap("", "<Space>", "<Nop>", opts)

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
-- scissors configuration
vim.keymap.set("n", "<leader>se", function() require("scissors").editSnippet() end, opts)
vim.keymap.set({ "n", "x" }, "<leader>sa", function() require("scissors").addNewSnippet() end, opts)
-- stylua: ignore end

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

-- fzf configuration
keymap("n", "<leader>ff", ":FzfLua files<CR>", opts)
keymap("n", "<leader>fb", ":FzfLua buffers<CR>", opts)
keymap("n", "<leader>fg", ":FzfLua live_grep<CR>", opts)
keymap("n", "<leader>fx", ":FzfLua diagnostics_workspace<CR>", opts)
keymap("n", "<leader>fo", ":FzfLua oldfiles<CR>", opts)
keymap("n", "<leader>fr", ":FzfLua resume<CR>", opts)
keymap("n", "<leader>fa", ":FzfLua lsp_code_actions<CR>", opts)
vim.keymap.set("n", "<leader>fc", function()
	local fzf = require("fzf-lua")
	local path = require("fzf-lua.path")
	local uv = vim.uv or vim.loop
	local cmd = "fd -t d . " .. uv.cwd()
	local function get_full_path(selected)
		if #selected < 1 then
			return
		end
		local entry = path.entry_to_file(selected[1], { cwd = uv.cwd() })
		if entry.path == "<none>" then
			return
		end
		-- Taken from require('fzf-lua').files, maybe there's a better way?
		local fullpath = entry.path or entry.uri and entry.uri:match("^%a+://(.*)")
		if not path.is_absolute(fullpath) then
			fullpath = path.join({ uv.cwd(), fullpath })
		end
		return fullpath
	end
	fzf.fzf_exec(cmd, {
		defaults = {},
		prompt = "Create file in dir> ",
		cwd = uv.cwd(),
		cwd_prompt_shorten_len = 32,
		cwd_prompt_shorten_val = 1,
		fzf_opts = {
			["--tiebreak"] = "end",
			["--preview"] = {
				type = "cmd",
				fn = function(selected)
					local fullpath = get_full_path(selected)
					return string.format("command ls -Alhv --group-directories-first %s", fullpath)
				end,
			},
		},
		fn_transform = function(x)
			return fzf.make_entry.file(x, { file_icons = true, color_icons = true, cwd = uv.cwd() })
		end,
		actions = {
			["default"] = function(selected)
				local fullpath = get_full_path(selected)
				vim.ui.input({ prompt = "File Name: " }, function(name)
					if name == nil then
						return
					end
					vim.cmd("e " .. fullpath .. name)
					vim.cmd("w ++p")
				end)
			end,
		},
	})
end, opts)
