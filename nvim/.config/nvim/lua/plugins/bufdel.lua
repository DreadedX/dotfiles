-- https://github.com/ojroques/nvim-bufdel
return {
	'ojroques/nvim-bufdel',
	cmd = { "BufDel", "BuffDelOthers" },
	keys = {
		{ '<leader>bd', function()
			require('bufdel').delete_buffer_expr(nil, false)
		end, silent = true, desc = '[B]uffer [d]elete' },
		{ '<leader>bD', function()
			require('bufdel').delete_buffer_others(false)
		end, silent = true, desc = '[B]uffer [D]elete others' },
	},
}
