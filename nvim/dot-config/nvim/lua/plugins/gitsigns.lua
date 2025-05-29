-- https://github.com/lewis6991/gitsigns.nvim
return {
	-- Adds git related signs to the gutter, as well as utilities for managing changes
	"lewis6991/gitsigns.nvim",
	opts = {
		signs = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "|" },
		},
		signs_staged = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "|" },
		},
		attach_to_untracked = true,
		current_line_blame_opts = {
			virt_text_pos = "eol",
			virt_text_priority = 1,
			delay = 200,
		},
	},
	init = function()
		local ga = require("gitsigns.actions")
		vim.keymap.set("n", "gs", ga.stage_hunk, { desc = "(Un)stage hunk" })
		vim.keymap.set("n", "gS", ga.stage_buffer, { desc = "Stage buffer" })
		vim.keymap.set("v", "gs", function()
			ga.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "(Un)stage selection" })

		vim.keymap.set("n", "gd", ga.preview_hunk, { desc = "Diff hunk" })

		vim.keymap.set("n", "<leader>tb", ga.toggle_current_line_blame, { desc = "Line blame" })
		vim.keymap.set("n", "gb", ga.blame_line, { desc = "View blame" })

		vim.keymap.set("n", "<leader>gr", ga.reset_hunk, { desc = "Reset hunk" })
		vim.keymap.set("n", "<leader>gR", ga.reset_buffer, { desc = "Reset buffer" })
		vim.keymap.set("v", "<leader>gr", function()
			ga.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "Git reset selection" })

		vim.keymap.set("n", "]g", function()
			ga.nav_hunk("next")
		end, { desc = "Next hunk" })
		vim.keymap.set("n", "[g", function()
			ga.nav_hunk("prev")
		end, { desc = "Previous hunk" })
	end,
}
