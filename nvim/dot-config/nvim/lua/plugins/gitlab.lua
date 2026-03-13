local window = require("symbols.window")
-- https://github.com/harrisoncramer/gitlab.nvim
--- @module "lazy"
--- @type LazySpec
return {
	"harrisoncramer/gitlab.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
	},
	cond = function()
		return vim.fn.executable("go") > 0
	end,
	build = function()
		require("gitlab.server").build(true)
	end, -- Builds the Go binary
	opts = {
		discussion_tree = {
			draft_mode = true,
		},
		popup = {
			border = window.border,
		},
		discussion_signs = {
			virtual_text = true,
		},
		keymaps = {
			discussion_tree = {
				toggle_node = "za",
				toggle_all_discussions = "zA",
			},
			popup = {
				perform_action = "w",
				discard_changes = "<esc>",
			},
		},
	},
}
