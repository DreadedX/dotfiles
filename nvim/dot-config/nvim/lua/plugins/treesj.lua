-- https://github.com/Wansmer/treesj
return {
	enabled = false,
	'Wansmer/treesj',
	keys = {
		{
			'<space>m',
			function()
				require('treesj').toggle()
			end,
			desc = "Split or Join code block"
		},
	},
	dependencies = { 'nvim-treesitter/nvim-treesitter' },
	opts = {
		use_default_keymaps = false,
	}
}
