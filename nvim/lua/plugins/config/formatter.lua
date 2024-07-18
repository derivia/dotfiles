local status_ok, plugin = pcall(require, "formatter")

if not status_ok then
	return
end

local util = require("formatter.util")

local clangformat_config_c = function()
	return {
		exe = "clang-format",
		args = {
			'--style="{ AllowShortFunctionsOnASingleLine: None, AlignConsecutiveMacros: true, AlignEscapedNewlines: Left, BreakBeforeBraces: Linux, SpaceAfterLogicalNot: false, SpaceAfterTemplateKeyword: false, SpaceAfterCStyleCast: false, ReferenceAlignment: Pointer, PointerAlignment: Right, ReflowComments: false, KeepEmptyLinesAtTheStartOfBlocks: false, KeepEmptyLinesAtEOF: false, IndentWidth: 2, ColumnLimit: 80 }"',
			"-assume-filename",
			util.escape_path(util.get_current_buffer_file_path()),
		},
		stdin = true,
		try_node_modules = false,
	}
end

local prettierd_config = function()
	return {
		exe = "prettierd",
		args = { util.escape_path(util.get_current_buffer_file_path()) },
		stdin = true,
	}
end

plugin.setup({
	logging = true,
	log_level = vim.log.levels.WARN,
	filetype = {
		c = {
			require("formatter.filetypes.c").clangformat,
			clangformat_config_c,
		},
		cpp = {
			require("formatter.filetypes.c").clangformat,
			clangformat_config_c,
		},
		html = {
			require("formatter.filetypes.html").prettierd,
			prettierd_config,
		},
		json = {
			require("formatter.filetypes.json").prettierd,
			prettierd_config,
		},
		lua = {
			require("formatter.filetypes.lua").stylua,
			function()
				return {
					exe = "stylua",
					args = {
						"--search-parent-directories",
						"--stdin-filepath",
						util.escape_path(util.get_current_buffer_file_path()),
						"--",
						"-",
					},
					stdin = true,
				}
			end,
		},
		java = {
			require("formatter.filetypes.java").clangformat,
			function()
				return {
					exe = "clang-format",
					args = { "--style=Google", "--assume-filename=.java" },
					stdin = true,
				}
			end,
		},
		javascript = {
			require("formatter.filetypes.javascript").prettierd,
			prettierd_config,
		},
		javascriptreact = {
			require("formatter.filetypes.javascriptreact").prettierd,
			prettierd_config,
		},
		ruby = {
			require("formatter.filetypes.ruby").standardrb,
			function()
				return {
					exe = "standardrb",
					args = {
						"--format",
						"quiet",
						"--stderr",
						"--stdin",
						util.escape_path(util.get_current_buffer_file_path()),
					},
					stdin = true,
				}
			end,
		},
		typescript = {
			require("formatter.filetypes.typescript").prettierd,
			prettierd_config,
		},
		typescriptreact = {
			require("formatter.filetypes.typescriptreact").prettierd,
			prettierd_config,
		},
		["*"] = {
			require("formatter.filetypes.any").remove_trailing_whitespace,
		},
	},
})
