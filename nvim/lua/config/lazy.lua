require("lazy").setup({
	-- Necessary for some plugins
	{ "nvim-lua/plenary.nvim" },

	-- Colorscheme(s)
	{ "derivia/opera-vim", lazy = false, priority = 1000 },

	-- Save selected code as image, with syntax highlighting
	{
		"mistricky/codesnap.nvim",
		build = "make",
		keys = {
			{ "<leader>cc", mode = "x", "<cmd>CodeSnapSave<cr>", desc = "Save current selected text to ~/snaps" },
		},
	},

	-- Todo-List Management
	{
		"atiladefreitas/dooing",
		opts = {
			save_path = vim.fn.stdpath("data") .. "/personal-todos.json",
			keymaps = {
				add_due_date = "H",
			},
			window = {
				width = 80,
			},
			calendar = {
				language = "pt",
			},
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
		opts = {},
		cmd = "Trouble",
		keys = {
			{
				"<leader>fx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
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

	-- Completion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-cmdline" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lsp-signature-help" },
			{ "saadparwaiz1/cmp_luasnip" },
		},
		event = "InsertEnter",
	},

	-- Rust tools
	-- {
	-- 	"mrcjkb/rustaceanvim",
	-- 	version = "^5",
	-- 	ft = "rust",
	-- },

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
				backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },
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
							return {
								"--style={AllowShortFunctionsOnASingleLine: None, AlignConsecutiveMacros: true, AlignEscapedNewlines: Left, BreakBeforeBraces: Linux, SpaceAfterLogicalNot: false, SpaceAfterTemplateKeyword: false, SpaceAfterCStyleCast: false, ReferenceAlignment: Pointer, PointerAlignment: Right, ReflowComments: false, KeepEmptyLinesAtTheStartOfBlocks: false, KeepEmptyLinesAtEOF: false, IndentWidth: 2, ColumnLimit: 80}",
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
					javascript = { "biome", "estlint_d" },
					javascriptreact = { "biome", "estlint_d" },
					json = { "biome" },
					liquid = { "biome" },
					lua = { "stylua" },
					python = { "black" },
					rust = { "rustfmt" }, --
					svelte = { "biome" },
					typescript = { "biome", "estlint_d" },
					typescriptreact = { "biome", "estlint_d" },
					yaml = { "biome" },
					["_"] = { "trim_whitespace" }, -- on all filetypes that aren't configured
				},
				format_after_save = nil,
				vim.keymap.set({ "n", "v" }, "<leader><C-f>", function()
					conform.format({
						lsp_fallback = true,
						async = true,
						timeout_ms = 500,
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

	-- Fuzzy finder
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
					split = "belowright new",
					border = "none",
					backdrop = 0,
					fullscreen = false,
					preview = {
						border = "noborder",
						delay = 50,
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

	-- Surround text objects with something
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		opts = {},
	},

	-- Better typescript LSP & Linting
	{ "pmizio/typescript-tools.nvim" },

	-- Show color background preview on HEX colors
	{ "norcalli/nvim-colorizer.lua" },

	-- Add status line below
	{ "nvim-lualine/lualine.nvim" },
}, {
	ui = { border = "rounded" },
	change_detection = { notify = false },
})
