-- https://github.com/folke/trouble.nvim
return {
	'folke/trouble.nvim',
	cmd = { 'Trouble', 'TroubleToggle', },
	keys = {
		{ '<F3>', '<cmd>TroubleToggle workspace_diagnostics<cr>', desc = 'Goto previous buffer' },
	},
	config = function ()
		local symbols = require('constant.symbols');
		require('trouble').setup {
			icons = false,
			auto_close = true,
			fold_open = symbols.fold.open, -- icon used for open folds
			fold_closed = symbols.fold.close, -- icon used for closed folds
			use_diagnostic_signs = true,
		}
	end
}
