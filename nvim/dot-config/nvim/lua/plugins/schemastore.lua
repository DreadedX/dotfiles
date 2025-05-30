-- https://github.com/b0o/schemastore.nvim
--- @module "lazy"
--- @type LazySpec
return {
	"b0o/schemastore.nvim",
	config = function()
		vim.lsp.config("jsonls", {
			settings = {
				json = {
					validate = { enable = true },
					schemas = require("schemastore").json.schemas(),
				},
			},
		})

		vim.lsp.config("yamlls", {
			settings = {
				yaml = {
					-- Using the schemastore plugin for schemas.
					schemastore = { enable = false, url = "" },
					schemas = require("schemastore").yaml.schemas(),
				},
			},
		})
	end,
}
