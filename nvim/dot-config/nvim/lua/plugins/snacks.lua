-- https://github.com/folke/snacks.nvim
--- @module "lazy"
--- @type LazySpec
return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		--- @module "snacks"
		--- @type snacks.Config
		opts = {},
	},
}
