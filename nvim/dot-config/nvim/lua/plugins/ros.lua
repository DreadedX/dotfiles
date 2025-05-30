-- https://github.com/tadachs/ros-nvim
--- @module "lazy"
--- @type LazySpec
return {
	"tadachs/ros-nvim",
	opts = {
		only_workspace = true,
	},
	build = ":TSInstall ros",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-telescope/telescope.nvim",
	},
}
