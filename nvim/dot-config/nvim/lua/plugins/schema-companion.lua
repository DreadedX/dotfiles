-- https://github.com/cenk1cenk2/schema-companion.nvim
--- @module "schema-companion"
--- @type schema_companion.Matcher

--- @module "lazy"
--- @type LazySpec
return {
	"cenk1cenk2/schema-companion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"diogo464/kubernetes.nvim",
	},
	keys = {
		{
			"<leader>ys",
			function()
				local schemas = require("schema-companion").get_matching_schemas()
				if schemas == nil or #schemas == 0 or (#schemas == 1 and schemas[1].name == "none") then
					print("No matching schemas")
				else
					require("schema-companion").select_matching_schema()
				end
			end,
			desc = "Select schema",
		},
	},
	--- @module "schema-companion"
	--- @type schema_companion.Config
	opts = {},
}
