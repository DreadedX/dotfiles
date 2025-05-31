-- https://github.com/tadachs/ros-nvim
--- @module "lazy"
--- @type LazySpec
return {
	"tadachs/ros-nvim",
	event = { "BufRead", "BufNewFile" },
	opts = {
		only_workspace = true,
	},
	build = ":TSInstall ros",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
}
