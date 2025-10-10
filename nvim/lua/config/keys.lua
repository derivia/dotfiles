-- shorter default options
local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

-- space as leader key
keymap("", "<Space>", "<Nop>", opts)

-- center search results
keymap("n", "n", ":normal! nzz<CR>", opts)
keymap("n", "N", ":normal! Nzz<CR>", opts)

-- window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- resize the current window
keymap("n", "<S-Up>", ":resize +2<CR>", opts)
keymap("n", "<S-Down>", ":resize -2<CR>", opts)
keymap("n", "<S-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<S-Right>", ":vertical resize +2<CR>", opts)

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

-- go to manpage of current symbol under cursor
keymap("n", "<leader>fm", function()
	vim.cmd("Man " .. vim.fn.expand("<cword>"))
end, { desc = "Man page for word under cursor" })

if vim.fn.getenv("WSLENV") ~= vim.NIL then
	keymap("n", "gx", ":silent :execute '!wslview ' . shellescape(expand('<cfile>'), 1)<CR>", opts)
end

local function generate_table_of_contents()
	local cursor_line = vim.fn.line(".")
	local buf_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

	local function header_to_link(header_text)
		local title = header_text:gsub("^%s*(%S.*)%s*$", "%1")

		title = title:lower()
		title = title:gsub("%s+", "-")
		title = title:gsub("[^a-z0-9-]", "")
		title = title:gsub("-+", "-")
		title = title:gsub("^-", ""):gsub("-$", "")

		return title
	end

	local headers = {}
	for i, line in ipairs(buf_lines) do
		local level_match = line:match("^(#+)%s")
		if level_match then
			local level = level_match:len()
			if level >= 1 and level <= 5 then
				local title = line:gsub("^#+%s*(.*)", "%1")

				table.insert(headers, {
					level = level,
					title = title,
					link = header_to_link(title),
					line_num = i,
				})
			end
		end
	end

	if #headers == 0 then
		return
	end

	local toc_lines = { "## Table of Contents:", "" }
	for _, header in ipairs(headers) do
		local indent = string.rep("  ", header.level - 1)
		table.insert(toc_lines, string.format("%s- [%s](#%s)", indent, header.title, header.link))
	end
	vim.api.nvim_buf_set_lines(0, cursor_line - 1, cursor_line - 1, false, toc_lines)
end

keymap("n", "<leader>toc", generate_table_of_contents, {
	noremap = true,
	silent = true,
	desc = "Generate markdown table of contents",
})

-- split tags up and join line from below up
keymap("n", "<leader>lj", "f>a<CR><ESC>f<i<CR><ESC>k==", { desc = "Split tag onto new lines" })
keymap("n", "<leader>lk", "gJ", { desc = "Join line below" })
