require("lazy").setup({
	-- Necessary for some plugins
	{ "nvim-lua/plenary.nvim" },

	-- Colorscheme(s)
	{
		"navarasu/onedark.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			style = "dark",
			transparent = false,
			term_colors = true,
			ending_tildes = false,
			cmp_itemkind_reverse = false,
			code_style = {
				comments = "none",
				keywords = "none",
				functions = "none",
				strings = "none",
				variables = "none",
			},
			lualine = {
				transparent = false,
			},
			colors = {},
			highlights = {},
			diagnostics = {
				darker = true,
				undercurl = true,
				background = true,
			},
		},
	},

	-- Show hex colors
	{ "norcalli/nvim-colorizer.lua", config = true },

	-- Format textwidth on files
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

	-- Annotate classes and functions based on scope
	{
		"danymat/neogen",
		version = "*",
		opts = {
			type = "func",
		},
		keys = {
			{ "<leader>nf", mode = "n", "<cmd>Neogen<CR>", desc = "Annotate based on scope" },
		},
	},

	-- Project-wide renaming
	{
		"nvim-pack/nvim-spectre",
		keys = {
			{ "<leader>sp", "<cmd>Spectre<cr>", desc = "Open Spectre panel" },
		},
	},

	-- Diagnostics!
	{
		"folke/trouble.nvim",
		opts = {
			modes = {
				symbols = {
					win = {
						type = "split",
						relative = "win", -- relative to current window
						position = "right", -- right side
						size = 0.4, -- 40% of the window
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

	-- Treesitter parsing abstraction layer
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter-textobjects" },
		},
	},

	-- Auto cd to root
	{ "ahmedkhalf/project.nvim" },

	-- More icons for neovim
	{ "nvim-tree/nvim-web-devicons", config = true },

	-- Vertical tree file explorer
	{
		"nvim-tree/nvim-tree.lua",
		keys = {
			{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle NvimTree window" },
		},
	},

	{
		"saghen/blink.cmp",
		dependencies = "rafamadriz/friendly-snippets",
		version = "*",
		opts = {
			fuzzy = {
				implementation = "prefer_rust_with_warning",
			},
			cmdline = {
				enabled = true,
			},
			keymap = {
				preset = "default",
				["<Enter>"] = {
					function(cmp)
						if cmp.snippet_active() then
							return cmp.accept()
						else
							return cmp.select_and_accept()
						end
					end,
					"snippet_forward",
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
						return { "lsp", "path", "snippets" }
					end
				end,
			},
		},
	},

	-- Snippet engine
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		dependencies = {
			-- Big collection of snippets
			"rafamadriz/friendly-snippets",
		},
	},

	-- Mini buffer removing plugin
	{ "echasnovski/mini.bufremove", config = true, version = "*" },

	-- Easier LSP config
	{ "neovim/nvim-lspconfig", event = { "BufReadPre", "BufNewFile" } },

	-- Easier management of external tools, like LSP, DAP, formatters, etc.
	{ "williamboman/mason.nvim" },
	{ "WhoIsSethDaniel/mason-tool-installer.nvim" },

	-- Snippet management
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
					c = { "clang_format" },
					cpp = { "clang_format" },
					css = { "biome" },
					graphql = { "biome" },
					html = { "biome" },
					java = { "clang_format" },
					javascript = { "biome" },
					javascriptreact = { "biome" },
					json = { "biome" },
					liquid = { "biome" },
					lua = { "stylua" },
					python = { "black" },
					rust = { "rustfmt" },
					svelte = { "biome" },
					typescript = { "biome" },
					typescriptreact = { "biome" },
					yaml = { "yamlfmt" },
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

	-- Markdown autocmds
	{ "jakewvincent/mkdnflow.nvim", ft = "markdown" },

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
				return
			end

			fzf_lua.setup({
				winopts = {
					height = 0.85,
					width = 0.80,
					row = 0.35,
					col = 0.50,
					border = "rounded",
					backdrop = 60,
					fullscreen = false,
					preview = {
						border = "rounded",
						default = "builtin",
						delay = 0,
						layout = "flex",
					},
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

	-- Java/Spring development
	{ "nvim-java/nvim-java" },
}, {
	ui = { border = "rounded" },
	change_detection = { notify = false },
})
