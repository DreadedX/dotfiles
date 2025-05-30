-- https://github.com/ojroques/nvim-bufdel
--- @module "lazy"
--- @type LazySpec
return {
	"ojroques/nvim-bufdel",
	cmd = { "BufDel", "BuffDelOthers" },
	keys = {
		{
			"<leader>bd",
			function()
				require("bufdel").delete_buffer_expr(nil, false)
			end,
			silent = true,
			desc = "Buffer delete",
		},
		{
			"<leader>bD",
			function()
				require("bufdel").delete_buffer_others(false)
			end,
			silent = true,
			desc = "Buffer delete others",
		},
	},
}
