-- https://github.com/aznhe21/actions-preview.nvim
--- @module "lazy"
--- @type LazySpec
return {
	"aznhe21/actions-preview.nvim",
	opts = function()
		local hl = require("actions-preview.highlight")
		return {
			backend = { "telescope" },
			highlight_command = {
				hl.delta(),
			},
			telescope = {
				sorting_strategy = "ascending",
				layout_strategy = "vertical",
				layout_config = {
					width = 0.8,
					height = 0.9,
					prompt_position = "top",
					preview_cutoff = 20,
					preview_height = function(_, _, max_lines)
						return max_lines - 15
					end,
				},
			},
		}
	end,
}
