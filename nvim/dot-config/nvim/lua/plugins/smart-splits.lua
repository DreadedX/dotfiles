-- https://github.com/mrjones2014/smart-splits.nvim
return {
	"mrjones2014/smart-splits.nvim",
	dependencies = {
		"kwkarlwang/bufresize.nvim",
	},
	config = function()
		vim.keymap.set("n", "<M-h>", require("smart-splits").move_cursor_left)
		vim.keymap.set("n", "<M-j>", require("smart-splits").move_cursor_down)
		vim.keymap.set("n", "<M-k>", require("smart-splits").move_cursor_up)
		vim.keymap.set("n", "<M-l>", require("smart-splits").move_cursor_right)

		vim.keymap.set("n", "<C-w>r", require("smart-splits").start_resize_mode, { desc = "Enter resize mode" })

		vim.keymap.set("n", "<C-w>h", require("smart-splits").swap_buf_left, { desc = "Swap buffer to the left" })
		vim.keymap.set("n", "<C-w>j", require("smart-splits").swap_buf_down, { desc = "Swap buffer to the bottom" })
		vim.keymap.set("n", "<C-w>k", require("smart-splits").swap_buf_up, { desc = "Swap buffer to the top" })
		vim.keymap.set("n", "<C-w>l", require("smart-splits").swap_buf_right, { desc = "Swap buffer to the right" })

		require("smart-splits").setup({
			at_edge = "stop",
			cursor_follows_swapped_bufs = true,
			resize_mode = {
				silent = true,
				hooks = {
					on_enter = function()
						vim.notify("Entering resize mode...")
					end,
					on_leave = require("bufresize").register,
				},
			},
		})
	end,
}
