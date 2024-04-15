-- https://github.com/ray-x/lsp_signature.nvim
return {
	"ray-x/lsp_signature.nvim",
	event = "VeryLazy",
	dependencies = {
		"neovim/nvim-lspconfig",
	},
	opts = {
		hint_enable = false,
		handler_opts = {
			border = require("symbols.window").border,
		},
	},
}
