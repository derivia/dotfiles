local status_ok_lazy, _ = pcall(require, "lazy")
if not status_ok_lazy then
	vim.notify("LazyVim failed to load")
	return
end

_.setup({
	-- Necessary for some plugins
	{ "nvim-lua/plenary.nvim", branch = "master" },

	-- Enhanced UI for messages, cmdline and the popupmenu
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			cmdline = {
				enabled = true,
				view = "cmdline_popup",
			},
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
				},
				progress = {
					enabled = true,
					format = "lsp_progress",
					format_done = "lsp_progress_done",
					view = "mini",
				},
			},
			presets = {
				bottom_search = true,
				command_palette = false,
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = false,
			},
			routes = {
				{
					filter = {
						event = "lsp",
						kind = "progress",
					},
					opts = { skip = false },
				},
			},
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
	},

	-- Annotation generator
	{
		"danymat/neogen",
		config = true,
		version = "*",
		keys = {
			{ "<leader>nd", "<cmd>Neogen<cr>", desc = "Generate annotation for current object" },
		},
	},

	-- Easier LSP config
	{ "neovim/nvim-lspconfig", event = { "BufReadPre", "BufNewFile" } },

	-- Cursor-like AI alternative
	{
		"olimorris/codecompanion.nvim",
		version = "17.33.0",
		config = function()
			local codecompanion = require("codecompanion")
			codecompanion.setup({})
			vim.keymap.set(
				"x",
				"<leader>cc",
				"<cmd>CodeCompanion<cr>",
				{ desc = "Call CodeCompanion on selected lines" }
			)
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"MeanderingProgrammer/render-markdown.nvim",
				ft = { "" },
			},
			{
				"echasnovski/mini.diff",
				config = function()
					local diff = require("mini.diff")
					diff.setup({
						source = diff.gen_source.none(),
					})
				end,
			},
		},
	},

	-- Copilot
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		-- event = "InsertEnter",
		keys = {
			{
				"<leader>cp",
				function()
					local status_ok, copilot = pcall(require, "copilot")
					if not status_ok then
						vim.notify("Something went wrong with Copilot startup.")
						return
					end
					copilot.setup({
						suggestion = { enabled = false },
						panel = { enabled = false },
						copilot_model = "gpt-5-mini",
						filetypes = {
							["*"] = false,
							["bash"] = true,
							["c"] = true,
							["cpp"] = true,
							["css"] = true,
							["dart"] = true,
							["elixir"] = true,
							["go"] = true,
							["html"] = true,
							["java"] = true,
							["javascript"] = true,
							["json"] = true,
							["kotlin"] = true,
							["lua"] = true,
							["markdown"] = true,
							["perl"] = true,
							["php"] = true,
							["python"] = true,
							["r"] = true,
							["ruby"] = true,
							["rust"] = true,
							["scala"] = true,
							["sh"] = true,
							["swift"] = true,
							["typescript"] = true,
							["yaml"] = true,
						},
					})
					vim.notify("Copilot started")
				end,
				desc = "Start Copilot",
			},
		},
	},

	-- Custom snippets management
	{
		"chrisgrieser/nvim-scissors",
		keys = {
			{ "<leader>se", "<cmd>ScissorsEditSnippet<cr>", desc = "Edit snippets for this filetype" },
			{
				"<leader>sa",
				mode = "x",
				"<cmd>ScissorsAddNewSnippet<cr>",
				desc = "Add selected code as snippet for this filetype",
			},
		},
		opts = {
			snippetDir = vim.fn.stdpath("config") .. "/snippets",
		},
	},

	-- Some simple utilitary plugins
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		keys = {
			{
				"<leader>nc",
				function()
					require("snacks").notifier.hide()
				end,
				desc = "Dismiss all notifications",
			},
			{
				"<leader>nh",
				function()
					require("snacks").notifier.show_history()
				end,
				desc = "Show notification history",
			},
		},
		opts = {
			picker = { enabled = true },
			notifier = {
				enabled = true,
				timeout = 999999,
				style = "compact",
				top_down = true,
				level = vim.log.levels.INFO,
			},
		},
		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					---@diagnostic disable-next-line: duplicate-set-field
					vim.notify = function(msg, level, opts)
						return require("snacks").notifier.notify(msg, level, opts)
					end
				end,
			})
		end,
	},

	-- Gruvbox colorscheme
	{ "ellisonleao/gruvbox.nvim", priority = 1000, config = true },

	-- Show hex colors
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			local status_ok, colorizer = pcall(require, "colorizer")
			if not status_ok then
				vim.notify("Something went wrong with nvim-colorizer startup.")
				return
			end
			colorizer.setup({})
		end,
	},

	-- Smarter line breaking
	{
		"paulshuker/textangle.nvim",
		version = "*",
		opts = {
			line_width = 80,
			keep_indent = true,
			keep_prefixes = { "-- ", "// ", "# " },
			hyphenate = false,
			hyphenate_minimum_gap = 10,
			hyphenate_overflow = false,
			disable = false,
		},
		keys = {
			{ "<leader>gl", mode = "n", "<cmd>TextangleLine<CR>", desc = "Break line into textwidth" },
		},
	},

	-- Project-wide renaming
	{
		"nvim-pack/nvim-spectre",
		keys = {
			{ "<leader>sp", "<cmd>Spectre<cr>", desc = "Open Spectre panel" },
		},
	},

	-- Diagnostics
	{
		"folke/trouble.nvim",
		opts = {
			modes = {
				symbols = {
					win = {
						type = "split",
						relative = "win",
						position = "right",
						size = 0.4,
					},
				},
			},
		},
		cmd = "Trouble",
		keys = {
			{
				"<leader>fx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>fs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
		},
	},

	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy",
		priority = 1000,
		config = function()
			require("tiny-inline-diagnostic").setup({
				preset = "classic",
				transparent_bg = false,
				transparent_cursorline = true,
				hi = {
					error = "DiagnosticError",
					warn = "DiagnosticWarn",
					info = "DiagnosticInfo",
					hint = "DiagnosticHint",
					arrow = "NonText",
					background = "CursorLine",
					mixing_color = "Normal",
				},
				disabled_ft = {},

				options = {
					show_source = {
						enabled = true, -- Enable showing source names
						if_many = false, -- Only show source if multiple sources exist for the same diagnostic
					},

					-- Use icons from vim.diagnostic.config instead of preset icons
					use_icons_from_diagnostic = true,

					-- Color the arrow to match the severity of the first diagnostic
					set_arrow_to_diag_color = false,

					-- Throttle update frequency in milliseconds to improve performance
					-- Higher values reduce CPU usage but may feel less responsive
					-- Set to 0 for immediate updates (may cause lag on slow systems)
					throttle = 20,

					-- Minimum number of characters before wrapping long messages
					softwrap = 30,

					-- Control how diagnostic messages are displayed
					-- NOTE: When using display_count = true, you need to enable multiline diagnostics with multilines.enabled = true
					--       If you want them to always be displayed, you can also set multilines.always_show = true.
					add_messages = {
						messages = true, -- Show full diagnostic messages
						display_count = false, -- Show diagnostic count instead of messages when cursor not on line
						use_max_severity = false, -- When counting, only show the most severe diagnostic
						show_multiple_glyphs = true, -- Show multiple icons for multiple diagnostics of same severity
					},

					-- Settings for multiline diagnostics
					multilines = {
						enabled = false, -- Enable support for multiline diagnostic messages
						always_show = false, -- Always show messages on all lines of multiline diagnostics
						trim_whitespaces = false, -- Remove leading/trailing whitespace from each line
						tabstop = 4, -- Number of spaces per tab when expanding tabs
						severity = nil, -- Filter multiline diagnostics by severity (e.g., { vim.diagnostic.severity.ERROR })
					},

					-- Show all diagnostics on the current cursor line, not just those under the cursor
					show_all_diags_on_cursorline = false,

					-- Display related diagnostics from LSP relatedInformation
					show_related = {
						enabled = true, -- Enable displaying related diagnostics
						max_count = 3, -- Maximum number of related diagnostics to show per diagnostic
					},

					-- Enable diagnostics display in insert mode
					-- May cause visual artifacts; consider setting throttle to 0 if enabled
					enable_on_insert = false,

					-- Enable diagnostics display in select mode (e.g., during auto-completion)
					enable_on_select = false,

					-- Handle messages that exceed the window width
					overflow = {
						mode = "wrap", -- "wrap": split into lines, "none": no truncation, "oneline": keep single line
						padding = 0, -- Extra characters to trigger wrapping earlier
					},

					-- Break long messages into separate lines
					break_line = {
						enabled = false, -- Enable automatic line breaking
						after = 30, -- Number of characters before inserting a line break
					},

					-- Custom function to format diagnostic messages
					-- Receives diagnostic object, returns formatted string
					-- Example: function(diag) return diag.message .. " [" .. diag.source .. "]" end
					format = nil,

					-- Virtual text display priority
					-- Higher values appear above other plugins (e.g., GitBlame)
					virt_texts = {
						priority = 2048,
					},

					-- Filter diagnostics by severity levels
					-- Remove severities you don't want to display
					severity = {
						vim.diagnostic.severity.ERROR,
						vim.diagnostic.severity.WARN,
						vim.diagnostic.severity.INFO,
						vim.diagnostic.severity.HINT,
					},

					-- Events that trigger attaching diagnostics to buffers
					-- Default is {"LspAttach"}; change only if plugin doesn't work with your LSP setup
					overwrite_events = nil,

					-- Automatically disable diagnostics when opening diagnostic float windows
					override_open_float = false,
				},
			})
		end,
	},

	-- Treesitter parsing abstraction layer
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter-textobjects" },
		},
	},

	-- More icons for neovim
	{ "nvim-tree/nvim-web-devicons", config = true },

	-- Vertical tree file explorer
	{
		"nvim-tree/nvim-tree.lua",
		keys = {
			{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle NvimTree window" },
		},
	},

	-- Completion engine
	{
		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
			"giuxtaposition/blink-cmp-copilot",
		},
		version = "*",
		config = function()
			local status_ok, blink = pcall(require, "blink.cmp")
			if not status_ok then
				return
			end
			blink.setup({
				fuzzy = {
					implementation = "prefer_rust_with_warning",
				},
				cmdline = {
					enabled = true,
				},
				appearance = {
					kind_icons = {
						Copilot = "",
						Text = "󰉿",
						Method = "󰊕",
						Function = "󰊕",
						Constructor = "󰒓",
						Field = "󰜢",
						Variable = "󰆦",
						Property = "󰖷",
						Class = "󱡠",
						Interface = "󱡠",
						Struct = "󱡠",
						Module = "󰅩",
						Unit = "󰪚",
						Value = "󰦨",
						Enum = "󰦨",
						EnumMember = "󰦨",
						Keyword = "󰻾",
						Constant = "󰏿",
						Snippet = "󱄽",
						Color = "󰏘",
						File = "󰈔",
						Reference = "󰬲",
						Folder = "󰉋",
						Event = "󱐋",
						Operator = "󰪚",
						TypeParameter = "󰬛",
					},
				},
				keymap = {
					preset = "default",
					["<CR>"] = {
						"accept",
						"fallback",
					},
					["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
					["<S-Tab>"] = { "select_prev", "fallback" },
					["<C-k>"] = { "scroll_documentation_up", "fallback" },
					["<C-j>"] = { "scroll_documentation_down", "fallback" },
					["<C-space>"] = {
						function(cmp)
							cmp.show({ providers = { "lsp", "path", "snippets" } })
						end,
					},
				},
				completion = {
					menu = {
						border = "none",
						draw = {
							columns = {
								{ "label", "label_description", gap = 2 },
								{ "kind_icon" },
							},
						},
					},
					documentation = { window = { border = "none" }, auto_show = true, auto_show_delay_ms = 0 },
					ghost_text = { enabled = false },
					list = {
						selection = {
							preselect = false,
						},
					},
					trigger = {
						show_in_snippet = false,
					},
				},
				signature = { enabled = true, window = { border = "none" } },
				sources = {
					providers = {
						copilot = {
							name = "copilot",
							module = "blink-cmp-copilot",
							score_offset = 100,
							async = true,
						},
					},
					per_filetype = {
						codecompanion = { "codecompanion" },
					},
					---@diagnostic disable-next-line: unused-local
					default = function(ctx)
						local success, node = pcall(vim.treesitter.get_node)
						if
							success
							and node
							and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type())
						then
							return {}
						else
							return { "copilot", "lsp", "path", "snippets" }
						end
					end,
				},
			})
		end,
	},

	-- Auto end after "do", "def", "end", etc
	{ "RRethy/nvim-treesitter-endwise", event = "InsertEnter" },

	-- Autopairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			disable_filetype = { "markdown" },
			check_ts = true,
			ts_config = {
				javascript = { "template_string" },
			},
		},
	},
	{
		"windwp/nvim-ts-autotag",
		ft = { "javascript", "javascriptreact", "typescript", "typescriptreact", "svelte", "vue", "html" },
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},

	-- Mini buffer removing plugin
	{
		"echasnovski/mini.bufremove",
		config = function()
			-- close tab and go to another buffer, if there's one.
			local status_ok_br, br = pcall(require, "mini.bufremove")
			if not status_ok_br then
				return
			end
			-- code from LazyVim.editor.lua
			vim.keymap.set("n", "<C-x>", function()
				if vim.bo.modified then
					local choice =
						vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
					if choice == 1 then
						vim.cmd.write()
						br.delete(0)
					elseif choice == 2 then
						br.delete(0, true)
					end
				else
					br.delete(0)
				end
			end, { desc = "Close buffer with confirmation" })
		end,
		version = "*",
	},

	-- Mini highlighter, mainly for comments
	{
		"echasnovski/mini.hipatterns",
		config = function()
			local status_ok, hipatterns = pcall(require, "mini.hipatterns")
			if not status_ok then
				vim.notify("Something went wrong with Mini.Hipatterns startup.")
				return
			end
			hipatterns.setup({

				highlighters = {
					changeme = { pattern = "%f[%w]()CHANGEME()%f[%W]", group = "MiniHipatternsHack" },
					fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
					hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
					note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
					todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },

					hex_color = hipatterns.gen_highlighter.hex_color(),
				},
			})
		end,
		version = "*",
	},

	-- Easier management of external tools, like LSP, DAP, formatters, etc.
	{
		"mason-org/mason.nvim",
		dependencies = {
			{ "WhoIsSethDaniel/mason-tool-installer.nvim", version = "1.32.0" },
		},
	},

	-- Debug Adapter Protocol client
	{
		"mfussenegger/nvim-dap",
		version = "*",
    -- stylua: ignore
    keys = {
        { "<F5>", function() require("dap").continue() end, desc = "DAP: Continue execution" },
        { "<F6>", function() require("dap").pause() end, desc = "DAP: Pause execution" },
        { "<F7>", function() require("dap").step_out() end, desc = "DAP: Step out" },
        { "<F8>", function() require("dap").step_into() end, desc = "DAP: Step into" },
        { "<F9>", function() require("dap").step_over() end, desc = "DAP: Step over" },
        { "<F12>", function() require("dap").close() end, desc = "DAP: Close execution" },
        { "<leader>dc", function() require("dap").repl.open() end, desc = "DAP: Open debug console" },
        { "<leader>dr", function() require("dap").run_last() end, desc = "DAP: Rerun last debug adapter/config" },
        { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "DAP: Add/remove breakpoint into the current line" },
        { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "DAP: Set conditional breakpoint into the current line" },
      },
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
		end,
		dependencies = {
			{
				"nvim-neotest/neotest",
				dependencies = {
					"nvim-neotest/nvim-nio",
					"antoinemadec/FixCursorHold.nvim",
					"nvim-treesitter",
					"nvim-neotest/neotest-python",
				},
				keys = {
					{
						"<leader>rtf",
						function()
							require("neotest").run.run(vim.fn.expand("%"))
						end,
						desc = "neotest: Run all test in the current file",
					},
					{
						"<leader>rtd",
						function()
							require("neotest").run.run({ strategy = "dap", suite = false })
						end,
						desc = "neotest: Debug nearest test",
					},
					{
						"<leader>rtl",
						function()
							require("neotest").run.run_last()
						end,
						desc = "neotest: Re-run last test",
					},
					{
						"<leader>rtL",
						function()
							require("neotest").run.run_last({ strategy = "dap", suite = false })
						end,
						desc = "neotest: Debug last test",
					},
					{
						"<leader>rtt",
						function()
							require("neotest").run.run()
						end,
						desc = "neotest: Run nearest test",
					},
					{
						"<leader>rtS",
						function()
							require("neotest").run.stop()
						end,
						desc = "neotest: Stop the nearest test",
					},
					{
						"<leader>rto",
						function()
							require("neotest").output_panel.toggle()
						end,
						desc = "neotest: Toggle output panel",
					},
					{
						"<leader>rtO",
						function()
							require("neotest").output.open({ enter = true, auto_close = true })
						end,
						desc = "neotest: Show test output",
					},
					{
						"<leader>rtp",
						function()
							require("neotest").summary.toggle()
						end,
						desc = "neotest: Toggle summary panel",
					},
					{
						"<leader>rtc",
						function()
							require("neotest").output_panel.clear()
						end,
						desc = "neotest: Clean the output panel",
					},
				},
				opts = {
					log_level = vim.log.levels.OFF, -- default: WARN
					output = { open_on_run = true },
					summary = { open = "topleft vsplit | vertical resize 45" },
					status = { virtual_text = true },
					python = {
						dap = { justMyCode = true },
						runner = "pytest",
					},
				},
				config = function(_, opts)
					opts.adapters = {
						require("neotest-python")(opts.python),
					}
					require("neotest").setup(opts)
				end,
			},
			{
				"rcarriga/nvim-dap-ui",
				dependencies = { "nvim-dap", "nvim-neotest/nvim-nio" },
				keys = {
					{
						"<leader>dk",
						function()
							require("dapui").eval()
						end,
						desc = "DAP: Show debug info of the element under the cursor",
					},
					{
						"<leader>dg",
						function()
							require("dapui").toggle()
						end,
						desc = "DAP: Toggle DAP GUI",
					},
					{
						"<leader>dG",
						function()
							require("dapui").open({ reset = true })
						end,
						desc = "DAP: Reset DAP GUI layout size",
					},
				},
				config = function(_, opts)
					require("dapui").setup(opts)
					local normal_hl = "Normal"
					local breakpoint_hl = "DiagnosticInfo"
        -- stylua: ignore
				vim.fn.sign_define("DapBreakpoint", { text = "", texthl = breakpoint_hl, numhl = breakpoint_hl })
        -- stylua: ignore
				vim.fn.sign_define("DapBreakpointCondition", { text = "󰗦", texthl = breakpoint_hl, numhl = breakpoint_hl })
        -- stylua: ignore
				vim.fn.sign_define("DapStopped", { text = "→", texthl = normal_hl, numhl = normal_hl })
				end,
				opts = {
					controls = {
						element = "repl",
						enabled = true,
						icons = {
							disconnect = "",
							pause = "",
							play = "",
							run_last = "",
							step_back = "",
							step_into = "",
							step_out = "",
							step_over = "",
							terminate = "",
						},
					},
					element_mappings = {},
					expand_lines = true,
					floating = {
						border = "single",
						mappings = { close = { "q", "<Esc>" } },
					},
					force_buffers = true,
					icons = { collapsed = "", current_frame = "", expanded = "" },
					layouts = {
						{
							elements = {
								{ id = "scopes", size = 0.61 },
								{ id = "breakpoints", size = 0.13 },
								{ id = "stacks", size = 0.13 },
								{ id = "repl", size = 0.13 },
							},
							position = "right",
							size = 40,
						},
						{
							elements = {
								{ id = "watches", size = 0.25 },
								{ id = "console", size = 0.75 },
							},
							position = "bottom",
							size = 10,
						},
					},
					mappings = {
						edit = "e",
						expand = { "<CR>", "<2-LeftMouse>" },
						open = "o",
						remove = "d",
						repl = "r",
						toggle = "t",
					},
					render = {
						indent = 1,
						max_value_lines = 100,
					},
					open = { reset = true },
				},
			},
			{
				"mfussenegger/nvim-dap-python",
				ft = "python",
				config = function()
					require("dap-python").setup("debugpy-adapter")
					require("dap-python").test_runner = "pytest"
				end,
          -- stylua: ignore
          keys = {
            { "<leader>dt", function() require("dap-python").test_method() end, ft = "python", desc = "DAP: Run test method" },
          },
			},
		},
	},

	-- Useful UI plugin to use with others
	{
		"stevearc/dressing.nvim",
		opts = {
			input = {
				enabled = true,
				default_prompt = "Input",
				trim_prompt = true,
				title_pos = "center",
				start_in_insert = true,
				border = "rounded",
				relative = "cursor",
				prefer_width = 40,
				width = nil,
				max_width = { 140, 0.9 },
				min_width = { 20, 0.2 },
				buf_options = {},
				win_options = {
					wrap = false,
					list = true,
					listchars = "precedes:…,extends:…",
					sidescrolloff = 0,
				},
				mappings = {
					n = {
						["<Esc>"] = "Close",
						["<CR>"] = "Confirm",
					},
					i = {
						["<C-c>"] = "Close",
						["<CR>"] = "Confirm",
						["<Up>"] = "HistoryPrev",
						["<Down>"] = "HistoryNext",
					},
				},
				get_config = nil,
			},
			select = {
				enabled = true,
				backend = { "fzf_lua", "fzf", "builtin", "nui" },
				trim_prompt = true,
				telescope = nil,
				fzf = {
					window = {
						width = 0.5,
						height = 0.4,
					},
				},
				builtin = {
					show_numbers = true,
					border = "rounded",
					relative = "editor",

					buf_options = {},
					win_options = {
						cursorline = true,
						cursorlineopt = "both",
					},
					width = nil,
					max_width = { 140, 0.8 },
					min_width = { 40, 0.2 },
					height = nil,
					max_height = 0.9,
					min_height = { 10, 0.2 },
					mappings = {
						["<Esc>"] = "Close",
						["<C-c>"] = "Close",
						["<CR>"] = "Confirm",
					},
				},
				format_item_override = {},
				get_config = nil,
			},
		},
	},

	-- Code formatting
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local status_ok, conform = pcall(require, "conform")
			if not status_ok then
				vim.notify("Something went wrong with conform startup.")
				return
			end

			conform.setup({
				log_level = vim.log.levels.DEBUG,
				formatters = {
					clang_format = {
						command = "clang-format",
						append_args = function()
							local home_dir = os.getenv("HOME")
							local clang_format_path = home_dir .. "/.clang-format"
							return {
								"--style=file:" .. clang_format_path,
							}
						end,
					},
				},
				formatters_by_ft = {
					angular = { "prettierd" },
					c = { "clang_format" },
					cpp = { "clang_format" },
					css = { "biome" },
					graphql = { "biome" },
					html = { "prettierd" },
					java = { "clang_format" },
					javascript = { "biome" },
					javascriptreact = { "biome" },
					json = { "biome" },
					liquid = { "biome" },
					lua = { "stylua" },
					nginx = { "nginxfmt" },
					python = { "black" },
					ruby = { "rubocop" },
					rust = { "rustfmt" },
					sh = { "beautysh" },
					svelte = { "biome" },
					typescript = { "biome" },
					typescriptreact = { "biome" },
					yaml = { "yamlfmt" },
					zsh = { "beautysh" },
					["_"] = { "trim_whitespace" }, -- on all filetypes that aren't configured
				},
				format_after_save = nil,
				vim.keymap.set({ "n", "v" }, "<leader><C-f>", function()
					conform.format({
						lsp_fallback = true,
						async = true,
						timeout_ms = 300,
					})
				end, { desc = "Format file | range" }),
			})
		end,
	},

	-- Preview markdown live on browser
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && npm install",
		keys = {
			{ "<leader>mk", "<cmd>MarkdownPreviewToggle<cr>", desc = "Toggle markdown preview" },
		},
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},

	-- Markdown autocmds
	{
		"jakewvincent/mkdnflow.nvim",
		config = function()
			require("mkdnflow").setup()
		end,
	},

	-- Fuzzy finder | Live grep | Etc
	{
		"ibhagwan/fzf-lua",
		keys = {
			{ "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Search files recursively" },
			{ "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Switch between opened buffers" },
			{ "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Live grep recursively" },
			{ "<leader>fo", "<cmd>FzfLua oldfiles<cr>", desc = "Search into recent opened files" },
			{ "<leader>fr", "<cmd>FzfLua resume<cr>", desc = "Run the last command again" },
		},

		config = function()
			local actions = require("fzf-lua.actions")
			local status_ok, fzf_lua = pcall(require, "fzf-lua")
			if not status_ok then
				vim.notify("Something went wrong with fzf-lua startup.")
				return
			end

			fzf_lua.setup({
				winopts = {
					height = 0.85,
					width = 0.80,
					row = 0.50,
					col = 0.50,
					border = "rounded",
					backdrop = 100,
					fullscreen = false,
					preview = {
						border = "rounded",
						default = "builtin",
						delay = 0,
						layout = "flex",
					},
				},
				fzf_colors = {
					["bg"] = { "bg", "Normal" },
					["bg+"] = { "bg", "Normal" },
					["gutter"] = { "bg", "Normal" },
				},
				actions = {
					files = {
						false,
						["enter"] = actions.file_edit_or_qf,
						["ctrl-j"] = actions.file_split,
						["ctrl-l"] = actions.file_vsplit,
						["ctrl-t"] = actions.file_tabedit,
						["alt-q"] = actions.file_sel_to_qf,
						["alt-Q"] = actions.file_sel_to_ll,
					},
				},
			})
		end,
	},

	-- Surround things
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},

	-- Status line below
	{ "nvim-lualine/lualine.nvim" },
}, {
	ui = { border = "rounded" },
	change_detection = { notify = false },
})

require("config.plugconf")
