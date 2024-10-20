require("lazy").setup({
	-- Necessary for some plugins
	{ "nvim-lua/plenary.nvim" },

	-- Colorscheme(s)
	{ "rebelot/kanagawa.nvim", lazy = false, priority = 1000 },

	-- Code formatter
	{
		"mhartington/formatter.nvim",
		keys = {
			{ "<leader><C-f>", "<cmd>Format<cr>", desc = "Format current file using filetype formatter" },
		},
	},

	-- Print with syntax highlighting
	{
		"mistricky/codesnap.nvim",
		build = "make",
		-- If lazy, the snap doesn't work on first try
		lazy = false,
		keys = {
			{ "<leader>cc", mode = "x", "<cmd>CodeSnapSave<cr>", desc = "Save current selected text to ~/snaps" },
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
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

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
	{
		"mrcjkb/rustaceanvim",
		version = "^5",
		ft = "rust",
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
	{ "stevearc/dressing.nvim" },

	-- Autopairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = { disable_filetype = { "markdown" } },
	},

	-- Markdown autocmds
	{ "jakewvincent/mkdnflow.nvim", ft = "markdown" },

	-- Fuzzy finder
	{
		"ibhagwan/fzf-lua",
		config = true,
		keys = {
			{ "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Search files recursively" },
			{ "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Switch between opened buffers" },
			{ "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Live grep recursively" },
			{ "<leader>fo", "<cmd>FzfLua oldfiles<cr>", desc = "Search into recent opened files" },
			{ "<leader>fr", "<cmd>FzfLua resume<cr>", desc = "Run the last command again" },
		},
		opts = {
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
		},
	},

	-- Comment out and uncomment
	{
		"numToStr/Comment.nvim",
		dependencies = {
			{ "JoosepAlviste/nvim-ts-context-commentstring" },
		},
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
	install = {
		colorscheme = { "kanagawa" },
	},
})
