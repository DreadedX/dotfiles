-- https://github.com/folke/todo-comments.nvim
local diagnostic = require("symbols.diagnostic")

return {
	-- NOTE: Using a fork for the time being upstream does not support authors
	-- 'folke/todo-comments.nvim',
	"doongjohn/todo-comments.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		vim.keymap.set("n", "]t", function()
			require("todo-comments").jump_next()
		end, { desc = "Next todo comment" })

		vim.keymap.set("n", "[t", function()
			require("todo-comments").jump_prev()
		end, { desc = "Previous todo comment" })

		if pcall(require, "trouble") then
			-- TODO: Use cwd to only show todo's in the current file
			-- vim.keymap.set("n", "<F4>", "<cmd>TroubleToggle todo cwd=%<cr>", { desc = "Next todo comment" })
			vim.keymap.set("n", "<F4>", "<cmd>TroubleToggle todo<cr>", { desc = "Next todo comment" })
		end
		if pcall(require, "telescope") then
			vim.keymap.set("n", "<leader>st", "<cmd>TodoTelescope<cr>", { desc = "[S]earch [T]odo" })
		end

		require("todo-comments").setup({
			keywords = {
				FIX = { icon = diagnostic.bug },
				TODO = { icon = diagnostic.todo },
				HACK = { icon = diagnostic.hack },
				WARN = { icon = diagnostic.warning },
				PERF = { icon = diagnostic.performance },
				NOTE = { icon = diagnostic.note },
				TEST = { icon = diagnostic.test },
			},
			highlight = {
				-- TODO: Have multiline, but end when %p (punctuation) is at the end of a line
				multiline = false,
				before = "fg",
				pattern = [[(KEYWORDS)\s*(\([^\)]*\))?:]],
			},
			search = {
				pattern = [[\b(KEYWORDS)(\(.*\))?:]],
			},
			colors = {
				error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
				warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
				info = { "Todo", "#2563EB" },
				hint = { "DiagnosticHint", "#10B981" },
				default = { "Identifier", "#7C3AED" },
				test = { "Identifier", "#FF00FF" },
			},
		})
	end,
}
