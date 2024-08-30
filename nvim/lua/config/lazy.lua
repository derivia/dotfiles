require("lazy").setup({
	-- Necessary for some plugins
	{ "nvim-lua/plenary.nvim" },

	-- Colorscheme(s)
  { "rebelot/kanagawa.nvim", lazy = false, priority = 1000 },

	-- Code formatter
	{ "mhartington/formatter.nvim" },

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
	{ "hrsh7th/nvim-cmp", lazy = false },
	{ "hrsh7th/cmp-buffer", lazy = false },
	{ "hrsh7th/cmp-path", lazy = false },
	{ "hrsh7th/cmp-cmdline", lazy = false },
	{ "hrsh7th/cmp-nvim-lsp", lazy = false },
	{ "hrsh7th/cmp-nvim-lsp-signature-help", lazy = false },
	{ "saadparwaiz1/cmp_luasnip", lazy = false },

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

	-- Autopairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = { disable_filetype = { "markdown" } },
	},

	-- Markdown autocmds
	{
		"jakewvincent/mkdnflow.nvim",
	},

	-- Fuzzy finder
	{ "ibhagwan/fzf-lua", config = true },

	-- Comment out and uncomment
	{ "numToStr/Comment.nvim" },
	{ "JoosepAlviste/nvim-ts-context-commentstring" },

	-- Better typescript LSP & Linting
	{ "pmizio/typescript-tools.nvim" },

	-- Show color background preview on HEX colors
	{ "norcalli/nvim-colorizer.lua" },

	-- Add status line below
	{ "nvim-lualine/lualine.nvim", lazy = false },
}, {
	ui = { border = "rounded" },
	change_detection = { notify = false },
})
