-- https://github.com/mason-org/mason-lspconfig.nvim
--- @module "lazy"
--- @type LazySpec
return {
	"mason-org/mason-lspconfig.nvim",
	event = "VeryLazy",
	--- @module "mason-lspconfig"
	--- @type MasonLspconfigSettings
	opts = {},
	dependencies = {
		"mason-org/mason.nvim",
		"neovim/nvim-lspconfig",
	},
}
