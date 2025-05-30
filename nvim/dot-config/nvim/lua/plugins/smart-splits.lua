-- https://github.com/mrjones2014/smart-splits.nvim
--- @module "lazy"
--- @type LazySpec
return {
	"mrjones2014/smart-splits.nvim",
	opts = {
		at_edge = "stop",
		cursor_follows_swapped_bufs = true,
	},
	init = function()
		vim.keymap.set("n", "<M-h>", require("smart-splits").move_cursor_left)
		vim.keymap.set("n", "<M-j>", require("smart-splits").move_cursor_down)
		vim.keymap.set("n", "<M-k>", require("smart-splits").move_cursor_up)
		vim.keymap.set("n", "<M-l>", require("smart-splits").move_cursor_right)

		vim.keymap.set("n", "<C-w>h", require("smart-splits").swap_buf_left, { desc = "Swap buffer to the left" })
		vim.keymap.set("n", "<C-w>j", require("smart-splits").swap_buf_down, { desc = "Swap buffer to the bottom" })
		vim.keymap.set("n", "<C-w>k", require("smart-splits").swap_buf_up, { desc = "Swap buffer to the top" })
		vim.keymap.set("n", "<C-w>l", require("smart-splits").swap_buf_right, { desc = "Swap buffer to the right" })

		vim.keymap.set("n", "<M-left>", require("smart-splits").resize_left, { desc = "Resize buffer to the left" })
		vim.keymap.set("n", "<M-down>", require("smart-splits").resize_down, { desc = "Resize buffer to the bottom" })
		vim.keymap.set("n", "<M-up>", require("smart-splits").resize_up, { desc = "Resize buffer to the top" })
		vim.keymap.set("n", "<M-right>", require("smart-splits").resize_right, { desc = "Resize buffer to the right" })
	end,
}
