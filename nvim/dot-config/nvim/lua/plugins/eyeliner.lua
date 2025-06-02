-- https://github.com/jinh0/eyeliner.nvim
--- @module "lazy"
--- @type LazySpec
return {
	"jinh0/eyeliner.nvim",
	dependencies = {
		{
			"ellisonleao/gruvbox.nvim",
			opts = {
				overrides = {
					EyelinerPrimary = { bold = true, underline = true },
					EyelinerSecondary = { underline = true },
				},
			},
		},
	},
	opts = {
		highlight_on_key = true,
	},
}
