-- https://github.com/nvim-lualine/lualine.nvim

local function get_schema()
	if not (vim.bo.filetype == "yaml" or vim.bo.filetype == "json" or vim.bo.filetype == "toml") then
		return ""
	end

	-- The provided get_current_schema function returns nonenil when no schema is known.
	-- Instead we use a custom implemention that does not do that.
	-- Also has the added benefit of giving more control over formatting
	local schemas = require("schema-companion").get_matching_schemas()
	if schemas == nil or #schemas == 0 then
		return ""
	end

	schema = schemas[1]
	if schema.name == "none" then
		return ""
	end

	return ("%s%s"):format(schema.name, #schemas > 1 and (" (+%d)"):format(#schemas - 1) or "")
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
