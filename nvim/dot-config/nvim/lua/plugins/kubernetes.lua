-- https://github.com/diogo464/kubernetes.nvim
--- @module "lazy"
--- @type LazySpec
return {
	"diogo464/kubernetes.nvim",
	ft = "yaml",
	opts = {
		schema_strict = true,
		schema_generate_always = false,
	},
}
