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
		keys = {
			{
				"<leader>bd",
				function()
					Snacks.bufdelete.delete()
				end,
				silent = true,
				desc = "Buffer delete",
			},
			{
				"<leader>bD",
				function()
					Snacks.bufdelete.other()
				end,
				silent = true,
				desc = "Buffer delete others",
			},
		},
	},
}
