-- https://github.com/simrat39/symbols-outline.nvim
return {
	'simrat39/symbols-outline.nvim',
	keys = {
		{
			'<F5>',
			function()
				require('symbols-outline').toggle_outline()
			end,
			desc = 'Toggle symbols outline'
		},
	},
	opts = {},
}
