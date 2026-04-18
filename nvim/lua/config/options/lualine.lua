local status_ok, plugin = pcall(require, "lualine")

if not status_ok then
	return
end

-- from https://gist.github.com/Lamarcke/36e086dd3bb2cebc593d505e2f838e07
local function get_attached_clients()
	local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
	if #buf_clients == 0 then
		return "LSP Inactive"
	end

	local buf_ft = vim.bo.filetype
	local buf_client_names = {}

	-- add client
	for _, client in pairs(buf_clients) do
		if client.name ~= "copilot" and client.name ~= "null-ls" then
			table.insert(buf_client_names, client.name)
		end
	end

	local lint_s, lint = pcall(require, "lint")
	if lint_s then
		for ft_k, ft_v in pairs(lint.linters_by_ft) do
			if type(ft_v) == "table" then
				for _, linter in ipairs(ft_v) do
					if buf_ft == ft_k then
						table.insert(buf_client_names, linter)
					end
				end
			elseif type(ft_v) == "string" then
				if buf_ft == ft_k then
					table.insert(buf_client_names, ft_v)
				end
			end
		end
	end

	-- This needs to be a string only table so we can use concat below
	local unique_client_names = {}
	for _, client_name_target in ipairs(buf_client_names) do
		local is_duplicate = false
		for _, client_name_compare in ipairs(unique_client_names) do
			if client_name_target == client_name_compare then
				is_duplicate = true
			end
		end
		if not is_duplicate then
			table.insert(unique_client_names, client_name_target)
		end
	end

	local client_names_str = table.concat(unique_client_names, ", ")
	local language_servers = string.format("[%s]", client_names_str)

	return language_servers
end

local filetype = {
	"filetype",
	icons_enabled = true,
	padding = 1,
}
local filename = { "filename", path = 1 }
local diagnostics = { "diagnostics", always_visible = true }

local attached_clients = {
	get_attached_clients,
	color = {
		gui = "bold",
	},
}

local function visual_selection_count()
	local mode = vim.fn.mode()
	if not (mode == "v" or mode == "V" or mode == "\22") then -- not in visual mode
		return ""
	end

	local start_line = vim.fn.line("v")
	local end_line = vim.fn.line(".")
	local start_col = vim.fn.col("v")
	local end_col = vim.fn.col(".")

	local count_lines = math.abs(end_line - start_line) + 1

	local s_line, e_line = math.min(start_line, end_line), math.max(start_line, end_line)
	local s_col, e_col = start_col, end_col
	if start_line > end_line or (start_line == end_line and start_col > end_col) then
		s_col, e_col = end_col, start_col
	end

	local total_chars = 0
	for l = s_line, e_line do
		local line_text = vim.fn.getline(l)
		if l == s_line and l == e_line then
			total_chars = total_chars + (e_col - s_col)
		elseif l == s_line then
			total_chars = total_chars + (#line_text - s_col + 1)
		elseif l == e_line then
			total_chars = total_chars + (e_col - 1)
		else
			total_chars = total_chars + #line_text
		end
	end

	return tostring(count_lines) .. "L, " .. tostring(total_chars) .. "C"
end

local function recording_macro()
	local reg = vim.fn.reg_recording()
	if reg == "" then
		return ""
	end
	return "@" .. reg
end

vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
	callback = function()
		vim.defer_fn(function()
			require("lualine").refresh({ place = { "statusline" } })
		end, 50)
	end,
})

plugin.setup({
	options = {
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		refresh = {
			statusline = 100,
			tabline = 100,
			winbar = 100,
		},
		disabled_filetypes = { "alpha", "NvimTree" },
	},
	sections = {
		lualine_a = { "mode", visual_selection_count, recording_macro },
		lualine_b = { diagnostics },
		lualine_c = { filename },
		lualine_x = { attached_clients },
		lualine_y = { "encoding" },
		lualine_z = { filetype },
	},
})
