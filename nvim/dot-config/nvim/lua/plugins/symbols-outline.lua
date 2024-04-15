-- https://github.com/simrat39/symbols-outline.nvim
return {
	enabled = false,
	"simrat39/symbols-outline.nvim",
	keys = {
		{
			"<F5>",
			function()
				require("symbols-outline").toggle_outline()
			end,
			desc = "Toggle symbols outline",
		},
	},
	opts = {},
}
