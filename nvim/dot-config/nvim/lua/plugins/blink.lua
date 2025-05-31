-- https://github.com/saghen/blink.cmp
--- @module "lazy"
--- @type LazySpec
return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },
	event = "InsertEnter",

	-- use a release tag to download pre-built binaries
	version = "1.*",

	--- @module "blink-cmp"
	--- @type blink.cmp.Config
	opts = {
		keymap = {
			preset = "default",
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-u>"] = { "scroll_documentation_up" },
			["<C-d>"] = { "scroll_documentation_down" },

			["<CR>"] = { "accept", "fallback" },
			["<Esc>"] = {
				function(cmp)
					if cmp.is_visible() then
						cmp.cancel()
						if cmp.get_selected_item_idx() ~= nil or cmp.snippet_active() then
							return true
						end
					elseif cmp.snippet_active() then
						vim.snippet.stop()
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

			["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
		},

		appearance = {
			nerd_font_variant = "normal",
		},

		completion = {
			ghost_text = {
				enabled = true,
			},
			list = {
				selection = {
					preselect = false,
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
					score_offset = 100,
				},
			},
		},

		cmdline = {
			enabled = false,
		},

		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
