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
	{
		"nvim-neo-tree/neo-tree.nvim",
		opts = function(_, opts)
			local function on_move(data)
				Snacks.rename.on_rename_file(data.source, data.destination)
			end
			local events = require("neo-tree.events")
			opts.event_handlers = opts.event_handlers or {}
			vim.list_extend(opts.event_handlers, {
				{ event = events.FILE_MOVED, handler = on_move },
				{ event = events.FILE_RENAMED, handler = on_move },
			})
		end,
	},
}
