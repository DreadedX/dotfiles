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
				require("schema-companion").select_schema()
			end,
			desc = "Yaml schema",
			ft = "yaml",
		},
	},
	--- @module "schema-companion"
	--- @type schema_companion.Config
	opts = {},
}
