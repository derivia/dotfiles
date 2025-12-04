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
	if not (mode == "v" or mode == "V" or mode == "\22") then
		return ""
	end

	local l1, c1 = vim.fn.line("v"), vim.fn.col("v")
	local l2, c2 = vim.fn.line("."), vim.fn.col(".")

	local s_line, e_line = math.min(l1, l2), math.max(l1, l2)
	local s_col, e_col = c1, c2
	if (l2 < l1) or (l1 == l2 and c2 < c1) then
		s_col, e_col = c2, c1
	end

	local lines = e_line - s_line + 1

	local total_chars = 0

	for l = s_line, e_line do
		local text = vim.fn.getline(l)

		if l == s_line and l == e_line then
			total_chars = total_chars + (e_col - s_col + 1)
		elseif l == s_line then
			total_chars = total_chars + (vim.fn.strchars(text) - s_col + 1)
		elseif l == e_line then
			total_chars = total_chars + e_col
		else
			total_chars = total_chars + vim.fn.strchars(text)
		end
	end

	return string.format("%dL, %dC", lines, total_chars)
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
