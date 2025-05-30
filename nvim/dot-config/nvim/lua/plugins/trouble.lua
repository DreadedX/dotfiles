-- https://github.com/folke/trouble.nvim
local fold = require("symbols.fold")

--- @module "lazy"
--- @type LazySpec
return {
	"folke/trouble.nvim",
	cmd = { "Trouble", "TroubleToggle" },
	keys = {
		{ "<F3>", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Goto previous buffer" },
	},
	--- @module "trouble"
	--- @type trouble.Config
	opts = {
		icons = false,
		auto_close = true,
		fold_open = fold.open, -- icon used for open folds
		fold_closed = fold.close, -- icon used for closed folds
		use_diagnostic_signs = true,
	},
}
