-- https://github.com/mrjones2014/smart-splits.nvim
--- @module "lazy"
--- @type LazySpec
return {
	"mrjones2014/smart-splits.nvim",
	event = "VeryLazy",
	--- @module "smart-splits"
	--- @type SmartSplitsConfig
	opts = {
		at_edge = "stop",
		cursor_follows_swapped_bufs = true,
	},
	init = function()
		vim.keymap.set("n", "<M-h>", function()
			require("smart-splits").move_cursor_left()
		end)
		vim.keymap.set("n", "<M-j>", function()
			require("smart-splits").move_cursor_down()
		end)
		vim.keymap.set("n", "<M-k>", function()
			require("smart-splits").move_cursor_up()
		end)
		vim.keymap.set("n", "<M-l>", function()
			require("smart-splits").move_cursor_right()
		end)

		vim.keymap.set("n", "<C-w>h", function()
			require("smart-splits").swap_buf_left()
		end, { desc = "Swap buffer to the left" })
		vim.keymap.set("n", "<C-w>j", function()
			require("smart-splits").swap_buf_down()
		end, { desc = "Swap buffer to the bottom" })
		vim.keymap.set("n", "<C-w>k", function()
			require("smart-splits").swap_buf_up()
		end, { desc = "Swap buffer to the top" })
		vim.keymap.set("n", "<C-w>l", function()
			require("smart-splits").swap_buf_right()
		end, { desc = "Swap buffer to the right" })

		vim.keymap.set("n", "<M-left>", function()
			require("smart-splits").resize_left()
		end, { desc = "Resize buffer to the left" })
		vim.keymap.set("n", "<M-down>", function()
			require("smart-splits").resize_down()
		end, { desc = "Resize buffer to the bottom" })
		vim.keymap.set("n", "<M-up>", function()
			require("smart-splits").resize_up()
		end, { desc = "Resize buffer to the top" })
		vim.keymap.set("n", "<M-right>", function()
			require("smart-splits").resize_right()
		end, { desc = "Resize buffer to the right" })
	end,
}
