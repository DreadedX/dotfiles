-- https://github.com/nvim-lualine/lualine.nvim

local function get_schema()
	if not (vim.bo.filetype == "yaml" or vim.bo.filetype == "json" or vim.bo.filetype == "toml") then
		return ""
	end

	local schema = (require("schema-companion").get_current_schemas() or "none")
	if schema == "none" then
		return ""
	end
	return schema
end

--- @module "lazy"
--- @type LazySpec
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
				{
					get_schema,
				},
			},
		},
		inactive_sections = {
			lualine_c = {
				{ "filename", path = 1 },
			},
		},
	},
}
