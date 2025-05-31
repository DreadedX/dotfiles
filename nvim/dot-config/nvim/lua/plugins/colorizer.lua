-- https://github.com/NvChad/nvim-colorizer.lua
--- @module "lazy"
--- @type LazySpec
return {
	"NvChad/nvim-colorizer.lua",
	opts = {
		lazy_load = true,
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
}
