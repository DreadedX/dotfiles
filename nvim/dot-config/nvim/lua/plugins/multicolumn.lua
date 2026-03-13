-- https://github.com/aznhe21/fmbarina/multicolumn.nvim
local function enforced(rulers, scope)
	return {
		rulers = rulers,
		scope = scope or "window",
		full_column = false,
		to_line_end = true,
		bg_color = "#691b1b",
		fg_color = "#ffd8ad",
	}
end

--- @module "lazy"
--- @type LazySpec
return {
	"fmbarina/multicolumn.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		base_set = {
			full_column = true,
		},
		sets = {
			python = enforced({ 89 }),
			rust = enforced({ 101 }),
			gitcommit = function(_, win)
				local T = function(c, x, y)
					if c then
						return x
					else
						return y
					end
				end

				return enforced(
					{ T(vim.fn.line(".", win) == 1, 51, 73) },
					T(vim.fn.line(".", win) == 1, "line", "window")
				)
			end,
		},
	},
}
