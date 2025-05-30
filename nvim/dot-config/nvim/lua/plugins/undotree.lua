-- https://github.com/mbbill/undotree
--- @module "lazy"
--- @type LazySpec
return {
	"mbbill/undotree",
	keys = {
		{ "<F6>", vim.cmd.UndotreeToggle, desc = "Toggle undotree" },
	},
}
