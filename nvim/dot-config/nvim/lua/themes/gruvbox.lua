-- https://github.com/ellisonleao/gruvbox.nvim
return {
	"ellisonleao/gruvbox.nvim",
	priority = 1000,
	config = function()
		local palette = require("gruvbox").palette

		require("gruvbox").setup({
			background = "dark",
			italic = {
				strings = false,
			},
			overrides = {
				YankHighlight = { fg = palette.bright_blue, bg = palette.dark0, reverse = true },
				Search = { fg = palette.bright_aqua },
				IncSearch = { link = "Search" },
				NormalFloat = { bg = palette.dark0 },
				FloatBorder = { fg = palette.dark4 },
				TelescopePromptTitle = { fg = palette.light4 },
				TelescopePromptBorder = { link = "FloatBorder" },
				TelescopePromptPrefix = { fg = palette.bright_red },
				TelescopePreviewTitle = { link = "TelescopePreviewTitle" },
				TelescopePreviewBorder = { link = "FloatBorder" },
				TelescopeResultsTitle = { link = "TelescopePreviewTitle" },
				TelescopeResultsBorder = { link = "FloatBorder" },
				TelescopeMatching = { fg = palette.bright_aqua, bold = true },
				TelescopeSelection = { fg = palette.bright_blue },
				TelescopeSelectionCaret = { link = "TelescopeSelection" },
				CmpItemAbbrMatch = { fg = palette.bright_aqua, bold = true },
				CmpItemAbbrMatchFuzzy = { link = "CmpItemAbbrMatch" },
				CmpItemMenu = { fg = palette.dark2 },
				CmpItemKindFunction = { fg = palette.bright_red },
				CmpSelection = { fg = palette.dark0, bg = palette.bright_blue },
				LspReferenceText = { fg = palette.dark0, bg = palette.neutral_purple },
				LspReferenceRead = { link = "LspReferenceText" },
				LspReferenceWrite = { link = "LspReferenceText" },
				TodoCommentError = { fg = palette.bright_red },
				TodoCommentWarning = { fg = palette.bright_yellow },
				TodoCommentInfo = { fg = palette.light1 },
				TodoCommentHint = { fg = palette.bright_aqua },
				TodoCommentTest = { fg = palette.bright_purple },
				TodoCommentDefault = { fg = palette.bright_blue },
			},
		})

		-- Load the colorscheme
		vim.cmd.colorscheme("gruvbox")
	end,
}
