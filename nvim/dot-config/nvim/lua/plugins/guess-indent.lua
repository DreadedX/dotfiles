-- https://github.com/NMAC427/guess-indent.nvim
return {
	-- Adds a command to automatically detect the indentation settings
	-- Prefer to use .editorconfig for projects and modeline for files
	"NMAC427/guess-indent.nvim",
	keys = {
		{ "<leader>gi", "<cmd>GuessIndent<cr>", desc = "Guess indentation" },
	},
	opts = {
		auto_cmd = false,
	},
}
