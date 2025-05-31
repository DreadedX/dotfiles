-- https://github.com/lewis6991/gitsigns.nvim
--- @module "lazy"
--- @type LazySpec
return {
	-- Adds git related signs to the gutter, as well as utilities for managing changes
	"lewis6991/gitsigns.nvim",
	event = { "BufWritePost", "BufReadPre" },
	--- @module "gitsigns"
	--- @type Gitsigns.Config
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
		vim.keymap.set("n", "gs", function()
			require("gitsigns.actions").stage_hunk()
		end, { desc = "(Un)stage hunk" })
		vim.keymap.set("n", "gS", function()
			require("gitsigns.actions").stage_buffer()
		end, { desc = "Stage buffer" })
		vim.keymap.set("v", "gs", function()
			require("gitsigns.actions").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "(Un)stage selection" })

		vim.keymap.set("n", "gd", function()
			require("gitsigns.actions").preview_hunk()
		end, { desc = "Diff hunk" })

		vim.keymap.set("n", "<leader>tb", function()
			require("gitsigns.actions").toggle_current_line_blame()
		end, { desc = "Line blame" })
		vim.keymap.set("n", "gb", function()
			require("gitsigns.actions").blame_line()
		end, { desc = "View blame" })

		vim.keymap.set("n", "<leader>gr", function()
			require("gitsigns.actions").reset_hunk()
		end, { desc = "Reset hunk" })
		vim.keymap.set("n", "<leader>gR", function()
			require("gitsigns.actions").reset_buffer()
		end, { desc = "Reset buffer" })
		vim.keymap.set("v", "<leader>gr", function()
			require("gitsigns.actions").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "Git reset selection" })

		vim.keymap.set("n", "]g", function()
			require("gitsigns.actions").nav_hunk("next")
		end, { desc = "Next hunk" })
		vim.keymap.set("n", "[g", function()
			require("gitsigns.actions").nav_hunk("prev")
		end, { desc = "Previous hunk" })
	end,
}
