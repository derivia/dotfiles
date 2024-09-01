local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set("n", "<leader>fe", function()
	vim.cmd.RustLsp("explainError")
end, { silent = true, buffer = bufnr })
