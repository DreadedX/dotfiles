-- https://github.com/folke/which-key.nvim
return {
	"folke/which-key.nvim",
	opts = {
		preset = "modern",
		delay = function(ctx)
			return ctx.plugin and 0 or 500
		end,
		win = {
			border = "single",
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
	},
	init = function()
		-- TODO: Only make a category show up if there actually are any keybinds under it
		require("which-key").add({
			{ "<leader>b", group = "[B]buffer" },
			{ "<leader>b_", hidden = true },
			{ "<leader>c", group = "[C]ode" },
			{ "<leader>c_", hidden = true },
			{ "<leader>d", group = "[D]ocument" },
			{ "<leader>d_", hidden = true },
			{ "<leader>g", group = "[G]it" },
			{ "<leader>g_", hidden = true },
			{ "<leader>r", group = "[R]e[N]ame" },
			{ "<leader>r_", hidden = true },
			{ "<leader>s", group = "[S]earch" },
			{ "<leader>s_", hidden = true },
			{ "<leader>w", group = "[W]orkspace" },
			{ "<leader>w_", hidden = true },
		})
	end,
}
