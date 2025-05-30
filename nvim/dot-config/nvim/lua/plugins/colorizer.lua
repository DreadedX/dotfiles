-- https://github.com/NvChad/nvim-colorizer.lua
--- @module "lazy"
--- @type LazySpec
return {
	"NvChad/nvim-colorizer.lua",
	event = "VeryLazy",
	opts = {
		filetypes = {
			"*", -- Enable color highlighting for all files
			"!neo-tree", -- Exclude neo-tree
		},
		buftypes = {
			"*",
			"!prompt",
			"!popup",
		},
		always_update = true,
		user_default_options = {
			names = false,
		},
	},
	-- Fix lazy loading: https://github.com/NvChad/nvim-colorizer.lua
	config = function(_, opts)
		local colorizer = require("colorizer")
		colorizer.setup(opts)

		-- nvim-colorizer doesn't work on the initial buffer if we lazy load, so force it to attach
		-- on load.
		local bufnr = vim.api.nvim_get_current_buf()
		if bufnr and not colorizer.is_buffer_attached(bufnr) then
			colorizer.attach_to_buffer(bufnr)
		end
	end,
}
