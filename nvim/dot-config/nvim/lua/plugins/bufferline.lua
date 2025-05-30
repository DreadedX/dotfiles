-- https://github.com/akinsho/bufferline.nvim
local diagnostic = require("symbols.diagnostic")
local file = require("symbols.file")

--- @module "lazy"
--- @type LazySpec
return {
	"akinsho/bufferline.nvim",
	--- @module "bufferline"
	--- @type bufferline.UserConfig
	opts = {
		options = {
			show_buffer_icons = false,
			show_buffer_close_icons = false,
			diagnostics = "nvim_lsp",
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
	},
	init = function()
		-- Setup keybinds to move between buffers
		vim.keymap.set("n", "<tab>", function()
			require("bufferline").cycle(1)
		end, { silent = true, desc = "Goto next buffer" })
		vim.keymap.set("n", "<S-tab>", function()
			require("bufferline").cycle(-1)
		end, { silent = true, desc = "Goto previous buffer" })

		-- Setup keybinds to move buffers around
		vim.keymap.set("n", "<leader>b[", function()
			require("bufferline").move(-1)
		end, { silent = true, desc = "Move buffer to left" })
		vim.keymap.set("n", "<leader>b]", function()
			require("bufferline").move(1)
		end, { silent = true, desc = "Move buffer to right" })
	end,
}
