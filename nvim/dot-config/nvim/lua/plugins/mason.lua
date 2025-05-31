-- https://github.com/mason-org/mason.nvim
--- @module "lazy"
--- @type LazySpec
return {
	"mason-org/mason.nvim",
	cmd = { "Mason", "MasonUpdate", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
	--- @module "mason"
	--- @type MasonSettings
	opts = {},
}
