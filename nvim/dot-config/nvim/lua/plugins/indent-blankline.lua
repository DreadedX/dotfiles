-- https://github.com/lukas-reineke/indent-blankline.nvim
--- @module "lazy"
--- @type LazySpec
return {
	-- Add indentation guides even on blank lines
	"lukas-reineke/indent-blankline.nvim",
	-- Enable `lukas-reineke/indent-blankline.nvim`
	-- See `:help indent_blankline.txt`
	main = "ibl",
	---@module "ibl"
	---@type ibl.config
	opts = {
		indent = {
			char = "¦",
		},
		scope = { enabled = true, show_start = false, show_end = false },
	},
}
