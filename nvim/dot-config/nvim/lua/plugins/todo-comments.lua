-- https://github.com/folke/todo-comments.nvim
local diagnostic = require("symbols.diagnostic")

--- @module "lazy"
--- @type LazySpec
return {
	"folke/todo-comments.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	event = "VeryLazy",
	opts = {
		signs = false,
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
	},
	init = function()
		vim.keymap.set("n", "]t", function()
			require("todo-comments").jump_next()
		end, { desc = "Next todo comment" })

		vim.keymap.set("n", "[t", function()
			require("todo-comments").jump_prev()
		end, { desc = "Previous todo comment" })

		-- -- TODO: Use cwd to only show todo's in the current file
		-- -- vim.keymap.set("n", "<F4>", "<cmd>TroubleToggle todo cwd=%<cr>", { desc = "Next todo comment" })
		-- vim.keymap.set("n", "<F4>", "<cmd>TroubleToggle todo<cr>", { desc = "Next todo comment" })

		vim.keymap.set("n", "<leader>st", function()
			require("telescope").extensions["todo-comments"].todo()
		end, { desc = "Search todo" })
	end,
}
