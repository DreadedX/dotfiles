-- https://github.com/folke/todo-comments.nvim
local diagnostic = require("symbols.diagnostic")

return {
	-- 'folke/todo-comments.nvim',
	-- NOTE: This fork highlights the entire matched word, not just the keyword.
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
			vim.keymap.set("n", "<leader>st", "<cmd>TodoTelescope<cr>", { desc = "Search todo" })
		end

		require("todo-comments").setup({
			keywords = {
				-- FIX: Fix
				FIX = { icon = diagnostic.bug },
				-- TODO: Todo
				TODO = { icon = diagnostic.todo },
				-- HACK: Hack
				HACK = { icon = diagnostic.hack },
				-- WARN: Warn
				WARN = { icon = diagnostic.warn },
				-- PERF: Perf
				PERF = { icon = diagnostic.performance },
				-- NOTE: Note
				NOTE = { icon = diagnostic.note },
				-- TEST: Test
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
				error = { "TodoCommentError" },
				warning = { "TodoCommentWarning" },
				info = { "TodoCommentInfo" },
				hint = { "TodoCommentHint" },
				test = { "TodoCommentTest" },
				default = { "TodoCommentDefault" },
			},
		})
	end,
}
