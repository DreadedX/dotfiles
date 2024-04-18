-- https://github.com/folke/which-key.nvim
return {
	"folke/which-key.nvim",
	opts = {
		window = {
			border = "single",
			margin = { 1, 5, 2, 3 },
			padding = { 0, 0, 0, 0 },
		},
	},
	init = function()
		-- TODO: Only make a category show up if there actually are any keybinds under it
		require("which-key").register({
			["<leader>g"] = { name = "[G]it", _ = "which_key_ignore" },
			["<leader>b"] = { name = "[B]buffer", _ = "which_key_ignore" },
			["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
			["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
			["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
			["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
			["<leader>r"] = { name = "[R]e[N]ame", _ = "which_key_ignore" },
		})
	end,
}
