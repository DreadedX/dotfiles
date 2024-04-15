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
		},
	},
	init = function()
		vim.keymap.set("n", "<leader>gs", require("gitsigns.actions").stage_hunk, { desc = "[G]it [S]tage hunk" })
		vim.keymap.set("v", "<leader>gs", function()
			require("gitsigns.actions").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "[G]it [S]tage selection" })

		vim.keymap.set(
			"n",
			"<leader>gS",
			require("gitsigns.actions").undo_stage_hunk,
			{ desc = "[G]it undo [S]tage hunk" }
		)

		vim.keymap.set(
			"n",
			"<leader>gd",
			require("gitsigns.actions").preview_hunk_inline,
			{ desc = "[G]it [D]iff hunk" }
		)

		vim.keymap.set("n", "<leader>gr", require("gitsigns.actions").reset_hunk, { desc = "[G]it [R]eset hunk" })
		vim.keymap.set("v", "<leader>gr", function()
			require("gitsigns.actions").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "[G]it [R]eset selection" })

		vim.keymap.set("n", "]g", function()
			require("gitsigns.actions").nav_hunk("next")
		end, { desc = "Go to next hunk" })
		vim.keymap.set("n", "[g", function()
			require("gitsigns.actions").nav_hunk("prev")
		end, { desc = "Go to previous hunk" })
	end,
}
