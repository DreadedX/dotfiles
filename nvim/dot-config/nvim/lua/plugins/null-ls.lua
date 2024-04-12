return {
	enabled = false,
	'jose-elias-alvarez/null-ls.nvim',
	dependencies = {
		'nvim-lua/plenary.nvim',
	},
	event = "VeryLazy",
	config = function()
		local null_ls = require('null-ls')

		null_ls.setup {
			sources = {
				null_ls.builtins.code_actions.gitsigns,
			}
		}
	end,
}
