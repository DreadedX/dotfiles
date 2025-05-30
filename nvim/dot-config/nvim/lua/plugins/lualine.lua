-- https://github.com/nvim-lualine/lualine.nvim

local function get_schema()
	local schema = require("schema-companion.context").get_buffer_schema()
	if schema.name == "none" then
		return ""
	end
	return schema.name
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
