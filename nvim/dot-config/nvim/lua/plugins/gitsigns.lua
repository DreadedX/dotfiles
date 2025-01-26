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
			virt_text_pos = "right_align",
			delay = 200,
			priority = 9999,
		},
	},
	init = function()
		vim.keymap.set("n", "<leader>gs", require("gitsigns.actions").stage_hunk, { desc = "Stage hunk" })
		vim.keymap.set("v", "<leader>gs", function()
			require("gitsigns.actions").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "Stage selection" })

		vim.keymap.set("n", "<leader>gS", require("gitsigns.actions").undo_stage_hunk, { desc = "Undo stage hunk" })

		vim.keymap.set("n", "<leader>gd", require("gitsigns.actions").preview_hunk, { desc = "Diff hunk" })

		vim.keymap.set("n", "<leader>gb", require("gitsigns.actions").toggle_current_line_blame, { desc = "Blame" })

		vim.keymap.set("n", "<leader>gr", require("gitsigns.actions").reset_hunk, { desc = "Reset hunk" })
		vim.keymap.set("v", "<leader>gr", function()
			require("gitsigns.actions").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "Reset selection" })

		vim.keymap.set("n", "]g", function()
			require("gitsigns.actions").nav_hunk("next")
		end, { desc = "Next hunk" })
		vim.keymap.set("n", "[g", function()
			require("gitsigns.actions").nav_hunk("prev")
		end, { desc = "Previous hunk" })
	end,
}
