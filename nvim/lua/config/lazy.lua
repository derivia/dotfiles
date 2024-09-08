require("lazy").setup({
	-- Necessary for some plugins
	{ "nvim-lua/plenary.nvim" },

	-- Colorscheme(s)
	{ "rebelot/kanagawa.nvim", lazy = false, priority = 1000 },

	-- Code formatter
	{ "mhartington/formatter.nvim" },

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

	-- Toggable terminals
	{ "akinsho/toggleterm.nvim", config = true },

	-- Treesitter parsing abstraction layer
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

	-- Auto cd to root
	{ "notjedi/nvim-rooter.lua", lazy = false, config = true },

	-- More icons for neovim
	{ "nvim-tree/nvim-web-devicons", config = true },

	-- Vertical tree file explorer
	{ "nvim-tree/nvim-tree.lua" },

	-- Completion
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-nvim-lsp-signature-help" },
	{ "saadparwaiz1/cmp_luasnip" },

	-- Rust tools
	{
		"mrcjkb/rustaceanvim",
		version = "^5",
		lazy = false,
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
	{ "jakewvincent/mkdnflow.nvim" },

	-- Fuzzy finder
	{ "ibhagwan/fzf-lua", config = true },

	-- Comment out and uncomment
	{
		"numToStr/Comment.nvim",
		lazy = true,
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
		colorscheme = { "kanagawa " },
	},
})
