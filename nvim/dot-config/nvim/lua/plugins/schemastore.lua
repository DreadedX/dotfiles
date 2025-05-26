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
	end
}
