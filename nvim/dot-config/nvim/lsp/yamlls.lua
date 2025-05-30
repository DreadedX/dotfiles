return require("schema-companion").setup_client({
	settings = {
		yaml = {
			schemastore = { enable = false, url = "" },
			schemas = require("schemastore").yaml.schemas(),
		},
	},
})
