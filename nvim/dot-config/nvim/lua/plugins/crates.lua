-- https://github.com/Saecki/crates.nvim
--- @module "lazy"
--- @type LazySpec
return {
	"Saecki/crates.nvim",
	event = { "BufRead Cargo.toml" },
	tag = "stable",
	--- @type crates.UserConfig
	opts = {
		popup = {
			hide_on_select = true,
			border = require("symbols.window").border,
		},
		lsp = {
			enabled = true,
			actions = true,
			completion = true,
			hover = true,
		},
	},
}
