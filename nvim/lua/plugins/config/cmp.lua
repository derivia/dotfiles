local status_ok_cmp, cmp = pcall(require, "cmp")
local status_ok_luasnip, luasnip = pcall(require, "luasnip")
local status_ok_context, context = pcall(require, "cmp.config.context")

if not status_ok_luasnip and status_ok_cmp and status_ok_context then
	return
end

local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local truncate = function(string, len, filetype)
	if filetype == "rust" then
		local use_match = string:match("^(%(use [^)]+%))")
		if use_match then
			return use_match:sub(1, len - 1) .. ""
		end
	end
	if #string <= len then
		return string
	end

	return string:sub(1, len - 1) .. ""
end

cmp.setup({
	-- stop preselecting stuff
	preselect = cmp.PreselectMode.None,

	enabled = function()
		-- disable completion in comments
		-- taken from https://github.com/hrsh7th/nvim-cmp/wiki/Advanced-techniques
		-- keep command mode completion enabled when cursor is in a comment
		if vim.api.nvim_get_mode().mode == "c" then
			return true
		else
			return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
		end
	end,

	-- taken from https://github.com/hrsh7th/nvim-cmp/issues/980
	formatting = {
		format = function(_, vim_item)
			local filetype = vim.bo.filetype
			local max_width
			local cols = vim.o.columns
			if cols > 90 then
				max_width = math.floor(cols * 0.6)
			else
				max_width = math.floor(cols * 0.4)
			end

			if vim_item.menu then
				max_width = max_width / 2.5
				vim_item.menu = truncate(vim_item.menu, max_width, filetype)
			end

			vim_item.abbr = truncate(vim_item.abbr, max_width * 0.7, filetype)

			return vim_item
		end,
	},

	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},

	window = {
		completion = cmp.config.window.bordered({
			winhighlight = "Normal:,FloatBorder:,CursorLine:Visual,Search:None",
			col_offset = -3,
			side_padding = 0,
		}),
		documentation = cmp.config.window.bordered({
			winhighlight = "Normal:,FloatBorder:,CursorLine:Visual,Search:None",
		}),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-j>"] = cmp.mapping.scroll_docs(2),
		["<C-k>"] = cmp.mapping.scroll_docs(-2),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		-- Luasnip super-tab configuration:
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<Down>"] = cmp.mapping(function(fallback)
			cmp.close()
			fallback()
		end, { "i" }),
		["<Up>"] = cmp.mapping(function(fallback)
			cmp.close()
			fallback()
		end, { "i" }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "luasnip" },
	}),
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
		{ name = "cmdline" },
	}),
})
