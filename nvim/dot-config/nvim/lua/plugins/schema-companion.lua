-- https://github.com/cenk1cenk2/schema-companion.nvim
--- @module "schema-companion"
--- @type schema_companion.Matcher
local kubernetes = {
	name = "Kubernetes",
	match = function(bufnr)
		local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
		local kind = false
		local api_version = false

		for _, line in ipairs(lines) do
			if kind or vim.regex("^kind: .*$"):match_str(line) then
				kind = true
			end

			if api_version or vim.regex("^apiVersion: .*$"):match_str(line) then
				api_version = true
			end

			if kind and api_version then
				return {
					name = "Kubernetes",
					uri = require("kubernetes").yamlls_schema(),
				}
			end
		end

		return nil
	end,
}

--- @module "lazy"
--- @type LazySpec
return {
	"cenk1cenk2/schema-companion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"diogo464/kubernetes.nvim",
	},
	init = function()
		vim.keymap.set(
			"n",
			"<leader>ys",
			require("telescope").extensions.schema_companion.select_schema,
			{ desc = "Yaml schema" }
		)
	end,
	--- @module "schema-companion"
	--- @type schema_companion.Config
	opts = {
		enable_telescope = true,
		matchers = {
			kubernetes,
		},
		schemas = {},
	},
}
