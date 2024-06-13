-- https://github.com/akinsho/bufferline.nvim
local diagnostic = require("symbols.diagnostic")
local file = require("symbols.file")

return {
	"akinsho/bufferline.nvim",
	dependencies = {
		"ojroques/nvim-bufdel",
	},
	config = function()
		-- Enable mousemoveevent if possible
		vim.o.mousemoveevent = true

		local bufferline = require("bufferline")

		-- Setup keybinds to move between buffers
		vim.keymap.set("n", "<tab>", function()
			bufferline.cycle(1)
		end, { silent = true, desc = "Goto next buffer" })
		vim.keymap.set("n", "<S-tab>", function()
			bufferline.cycle(-1)
		end, { silent = true, desc = "Goto previous buffer" })

		-- Setup keybinds to move buffers around
		vim.keymap.set("n", "<leader>b[", function()
			bufferline.move(-1)
		end, { silent = true, desc = "[B]uffer to the [ left" })
		vim.keymap.set("n", "<leader>b]", function()
			bufferline.move(1)
		end, { silent = true, desc = "[B]uffer to the ] right" })

		bufferline.setup({
			options = {
				show_buffer_icons = false,
				show_buffer_close_icons = false,
				diagnostics = "nvim_lsp",
				-- close_command = "BufDel %d",
				-- right_mouse_command = "BufDel %d",
				separator_style = "thick",
				left_trunc_marker = "",
				right_trunc_marker = "",
				sort_by = "insert_at_end",
				indicator = {
					style = "none",
				},
				modified_icon = file.modified,
				---@diagnostic disable-next-line: unused-local
				diagnostics_indicator = function(count, level, diagnostics_dict, context)
					local s = " "
					for e, n in pairs(diagnostics_dict) do
						local sym = e == "error" and diagnostic.error .. " "
							or (e == "warning" and diagnostic.warn .. " ")
							or (e == "info" and diagnostic.info .. " " or diagnostic.hint .. " ")
						s = s .. n .. sym
					end
					return s
				end,
			},
		})
	end,
}
