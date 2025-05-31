-- https://github.com/j-hui/fidget.nvim
--- @module "lazy"
--- @type LazySpec
return {
	"j-hui/fidget.nvim",
	event = "LspAttach",
	opts = {
		notification = {
			window = {
				border = require("symbols.window").border,
				y_padding = 1,
				x_padding = 2,
			},
		},
	},
}
