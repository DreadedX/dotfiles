-- https://github.com/alexghergh/nvim-tmux-navigation
return {
	'alexghergh/nvim-tmux-navigation',
	event = "VeryLazy",
	config = function()
		local nvim_tmux_nav = require('nvim-tmux-navigation')

		nvim_tmux_nav.setup {
			disable_when_zoomed = true,
			keybindings = {
				left = '<M-h>',
				down = '<M-j>',
				up = '<M-k>',
				right = '<M-l>',
			},
		}
	end
}
