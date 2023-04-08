-- https://github.com/NMAC427/guess-indent.nvim
return {
	-- Adds a command to automatically detect the identation settings
	-- Prefer to use .editorconfig for projects and modeline for files
	'NMAC427/guess-indent.nvim',
	keys = {
		{ "<leader>gi", "<cmd>GuessIndent<cr>", desc = "[G]uess [I]ndentation" },
	},
	opts = {
		auto_cmd = false,
	},
}
