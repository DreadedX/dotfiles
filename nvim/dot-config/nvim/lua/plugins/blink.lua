return {
	"saghen/blink.cmp",
	-- optional: provides snippets for the snippet source
	dependencies = { "rafamadriz/friendly-snippets" },

	-- use a release tag to download pre-built binaries
	version = "1.*",

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- See :h blink-cmp-config-keymap for defining your own keymap
		-- keymap = { preset = "default" },
		keymap = {
			preset = "default",
			-- ["<C-u>"] = {function(cmp) cmp.scroll_documentation_up(4) end},
			-- ["<C-d>"] = {function(cmp) cmp.scroll_documentation_down(4) end},
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-u>"] = { "scroll_documentation_up" },
			["<C-d>"] = { "scroll_documentation_down" },

			["<CR>"] = { "accept", "fallback" },
			["<Esc>"] = {
				function(cmp)
					if cmp.is_visible() then
						cmp.cancel()
						if cmp.get_selected_item_idx() ~= nil then
							return true
						end
					end
				end,
				"fallback",
			},

			["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
			["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<C-p>"] = { "select_prev", "fallback_to_mappings" },
			["<C-n>"] = { "select_next", "fallback_to_mappings" },

			-- TODO: Does not appear to work?
			["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
		},

		appearance = {
			-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = "mono",
		},

		-- (Default) Only show the documentation popup when manually triggered
		completion = {
			ghost_text = {
				enabled = true,
			},
			list = {
				selection = {
					preselect = false,
					-- preselect = function(ctx)
					-- 	return vim.bo.filetype ~= "markdown"
					-- end,
				},
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 0,
			},
			menu = {
				auto_show = true,
				draw = {
					columns = {
						{ "label", "label_description", gap = 1 },
						{ "kind", "source_name", gap = 1 },
					},
					components = {
						source_name = {
							text = function(ctx)
								if ctx.source_id ~= "snippets" then
									return "[" .. ctx.source_name .. "]"
								end
							end,
						},
					},
				},
			},
		},

		signature = {
			enabled = true,
			trigger = {
				show_on_accept = true,
				show_on_insert = true,
			},
		},

		-- Default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		sources = {
			default = {
				"lazydev",
				"lsp",
				"path",
				"snippets",
				"buffer",
			},
			providers = {
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					-- make lazydev completions top priority (see `:h blink.cmp`)
					score_offset = 100,
				},
			},
		},

		-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
		-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
		-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
		--
		-- See the fuzzy documentation for more information
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
