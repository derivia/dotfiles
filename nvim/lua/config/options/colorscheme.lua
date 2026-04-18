---@diagnostic disable: unused-local
local colorscheme = "onedark"

if colorscheme == "NeoSolarized" then
	local status_ok_neo, neo = pcall(require, "NeoSolarized")
	if not status_ok_neo then
		vim.notify("NeoSolarized startup failed")
		return
	end
	neo.setup({
		style = "dark", -- "dark" or "light"
		transparent = false,
		terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
		enable_italics = false, -- Italics for different hightlight groups (eg. Statement, Condition, Comment, Include, etc.)
		styles = {
			-- Style to be applied to different syntax groups
			comments = { italic = true },
			keywords = { italic = true },
			functions = { bold = false },
			variables = {},
			string = { italic = true },
			underline = true, -- true/false; for global underline
			undercurl = true, -- true/false; for global undercurl
		},
	})
end

if colorscheme == "monokai-pro" then
	local status_ok_mono, mono = pcall(require, "monokai-pro")
	if not status_ok_mono then
		vim.notify("Monokai-pro startup failed")
		return
	end
	mono.setup({
		transparent_background = false,
		terminal_colors = true,
		devicons = true,
		styles = {
			comment = { italic = true },
			keyword = { italic = true },
			type = { italic = true },
			storageclass = { italic = true },
			structure = { italic = true },
			parameter = { italic = true },
			annotation = { italic = true },
			tag_attribute = { italic = true },
		},
		filter = "machine", -- classic | octagon | pro | machine | ristretto | spectrum
		inc_search = "background", -- underline | background
		background_clear = {
			"toggleterm",
			"telescope",
			"renamer",
			"notify",
		},
		plugins = {
			bufferline = {
				underline_selected = false,
				underline_visible = false,
				underline_fill = false,
				bold = true,
			},
			indent_blankline = {
				context_highlight = "default", -- default | pro
				context_start_underline = false,
			},
		},
		override = function(scheme)
			return {}
		end,
		override_palette = function(filter)
			return {
				background = "#403e41",
			}
		end,
		override_scheme = function(scheme, palette, colors)
			return {}
		end,
	})
end

if colorscheme == "catppuccin" then
	vim.g.catppuccin_flavour = "frappe" -- latte, frappe, macchiato, mocha
	local status_ok_cat, cat = pcall(require, "catppuccin")
	if not status_ok_cat then
		vim.notify("Catppuccin startup failed")
		return
	end
	cat.setup({
		flavour = "auto", -- latte, frappe, macchiato, mocha
		background = { -- :h background
			light = "latte",
			dark = "mocha",
		},
		transparent_background = false, -- disables setting the background color.
		float = {
			transparent = false, -- enable transparent floating windows
			solid = false, -- use solid styling for floating windows, see |winborder|
		},
		show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
		term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
		dim_inactive = {
			enabled = false, -- dims the background color of inactive window
			shade = "dark",
			percentage = 0.15, -- percentage of the shade to apply to the inactive window
		},
		no_italic = false, -- Force no italic
		no_bold = false, -- Force no bold
		no_underline = false, -- Force no underline
		styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
			comments = { "italic" }, -- Change the style of comments
			conditionals = { "italic" },
			loops = {},
			functions = {},
			keywords = {},
			strings = {},
			variables = {},
			numbers = {},
			booleans = {},
			properties = {},
			types = {},
			operators = {},
			-- miscs = {}, -- Uncomment to turn off hard-coded styles
		},
		lsp_styles = { -- Handles the style of specific lsp hl groups (see `:h lsp-highlight`).
			virtual_text = {
				errors = { "italic" },
				hints = { "italic" },
				warnings = { "italic" },
				information = { "italic" },
				ok = { "italic" },
			},
			underlines = {
				errors = { "underline" },
				hints = { "underline" },
				warnings = { "underline" },
				information = { "underline" },
				ok = { "underline" },
			},
			inlay_hints = {
				background = true,
			},
		},
		color_overrides = {},
		custom_highlights = {},
		default_integrations = true,
		auto_integrations = false,
		integrations = {
			cmp = true,
			gitsigns = true,
			nvimtree = true,
			notify = false,
			mini = {
				enabled = true,
				indentscope_color = "",
			},
		},
	})
end

local status_ok_applied, colorscheme_applied = pcall(vim.cmd.colorscheme, colorscheme)

if not status_ok_applied then
	vim.notify(string.format("failed to apply %s", colorscheme_applied))
	return
end
