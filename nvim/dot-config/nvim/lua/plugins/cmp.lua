-- https://github.com/hrsh7th/nvim-cmp
return {
	{
		-- Autocompletion
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"onsails/lspkind-nvim",

			-- Improve sorting order for rust
			"zjp-CN/nvim-cmp-lsp-rs",

			-- Snippets
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")
			local border = require("symbols.window").border

			local cmp_rs = require("cmp_lsp_rs")
			local comparators = cmp_rs.comparators

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = { completeopt = "menu,menuone,noinsert" },
				window = {
					completion = cmp.config.window.bordered({
						border = border,
						winhighlight = "CursorLine:CmpSelection",
					}),
					documentation = cmp.config.window.bordered({ border = border }),
				},
				-- Include the source of the cmp entry
				formatting = {
					format = lspkind.cmp_format({
						mode = "text",
						menu = {
							nvim_lsp = "LSP",
							luasnip = "LuaSnip",
							path = "Path",
						},
					}),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete({}),
					["<CR>"] = cmp.mapping.confirm({
						select = true,
					}),
					["<Esc>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.abort()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
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
				}),
				sorting = {
					comparators = {
						comparators.inherent_import_inscope,
						comparators.sort_by_label_but_underscore_last,
					},
				},
				sources = {
					{ name = "lazydev", group_index = 0 },
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
				},
			})
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
		cond = function()
			return vim.fn.executable("make") == 1
		end,
		config = function()
			require("luasnip").config.setup()
			-- require("luasnip.loaders.from_vscode").lazy_load()
		end,
		dependencies = {
			-- "rafamadriz/friendly-snippets",
		},
	},
}
