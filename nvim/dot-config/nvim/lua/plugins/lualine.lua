-- https://github.com/nvim-lualine/lualine.nvim

local function get_schema()
	local schema = require("yaml-companion").get_buf_schema(0)
	if schema.result[1].name == "none" then
		return ""
	end
	return schema.result[1].name
end

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
				get_schema,
			},
		},
		inactive_sections = {
			lualine_c = {
				{ "filename", path = 1 },
			},
		},
	},
}
