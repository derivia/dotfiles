require("lazy").setup({
	-- Necessary for some plugins
	{ "nvim-lua/plenary.nvim" },

	-- Colorscheme(s)
	{ "tjdevries/colorbuddy.nvim", lazy = false, priority = 1000 },
	{ "sainnhe/sonokai", lazy = false, priority = 1000 },
	{ "nyoom-engineering/oxocarbon.nvim", lazy = false, priority = 1000 },
	{ "rebelot/kanagawa.nvim", lazy = false, priority = 1000 },

	-- Code formatter
	{ "mhartington/formatter.nvim" },

	-- Toggable terminals
	{ "akinsho/toggleterm.nvim", config = true },

	-- Treesitter parsing abstraction layer
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

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

	-- Modular mini plugins
	{ "echasnovski/mini.bufremove", config = true, version = "*" },

	-- Easier LSP config
	{ "neovim/nvim-lspconfig", event = { "BufReadPre", "BufNewFile" } },

	-- Easier management of external software, like LSP, DAP, formatters, etc.
	{ "williamboman/mason.nvim" },
	{ "WhoIsSethDaniel/mason-tool-installer.nvim" },

	-- Pretty diagnostics
	{ "folke/trouble.nvim" },

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

	-- Telescope related plugins
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
			"nvim-telescope/telescope-ui-select.nvim",
		},
		branch = "0.1.x",
	},

	-- Buffers on top
	{ "akinsho/bufferline.nvim", event = "VeryLazy" },

	-- Incremental renaming
	{ "smjonas/inc-rename.nvim", config = true },

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
