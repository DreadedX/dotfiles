-- https://github.com/folke/which-key.nvim
local window = require("symbols.window")
--- @module "lazy"
--- @type LazySpec
return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	--- @module "which-key"
	--- @type wk.Opts
	opts = {
		preset = "modern",
		delay = function(ctx)
			return ctx.plugin and 0 or 500
		end,
		win = {
			border = window.border,
			padding = { 1, 1 },
			title = false,
		},
		icons = {
			mappings = false,
			colors = false,
			keys = {
				Up = "<u> ",
				Down = "<d> ",
				Left = "<l> ",
				Right = "<r> ",
				C = "<c> ",
				M = "<m> ",
				S = "<s> ",
				CR = "<cr> ",
				Esc = "<esc> ",
				BS = "<bs>",
				Space = "<space> ",
				Tab = "<tab> ",
				F1 = "<F1> ",
				F2 = "<F2> ",
				F3 = "<F3> ",
				F4 = "<F4> ",
				F5 = "<F5> ",
				F6 = "<F6> ",
				F7 = "<F7> ",
				F8 = "<F8> ",
				F9 = "<F9> ",
				F10 = "<F10> ",
				F11 = "<F11> ",
				F12 = "<F12> ",
			},
		},
		expand = 1,
		sort = { "alphanum" },
		spec = {
			{ "<leader>b", group = "Buffer" },
			{ "<leader>d", group = "Doument" },
			{ "<leader>g", group = "Git" },
			{ "<leader>t", group = "Toggle" },
			{ "<leader>s", group = "Search" },
			{ "gr", group = "LSP" },
		},
	},
}
