-- https://github.com/nvim-lualine/lualine.nvim
return {
	"nvim-lualine/lualine.nvim",
	opts = {
		options = {
			icons_enabled = true,
			theme = "gruvbox",
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
		},
		sections = {
			lualine_b = {
				"branch",
				"diff",
				{
					"diagnostics",
					symbols = require("symbols.diagnostic"),
				},
			},
			lualine_c = {
				{
					"filename",
					path = 1,
					symbols = require("symbols.file"),
				},
			},
			lualine_x = {
				"encoding",
				{ "fileformat", icons_enabled = false },
				"filetype",
			},
		},
		inactive_sections = {
			lualine_c = {
				{ "filename", path = 1 },
			},
		},
	},
}
