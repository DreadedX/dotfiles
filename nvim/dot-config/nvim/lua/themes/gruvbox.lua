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
				LspInfoBorder = { link = "FloatBorder" },
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
				LspReferenceText = { bg = palette.dark1 },
				LspReferenceRead = { link = "LspReferenceText" },
				LspReferenceWrite = { link = "LspReferenceText" },
				TodoCommentError = { fg = palette.bright_red },
				TodoCommentWarning = { fg = palette.bright_yellow },
				TodoCommentInfo = { fg = palette.light1 },
				TodoCommentHint = { fg = palette.bright_aqua },
				TodoCommentTest = { fg = palette.bright_purple },
				TodoCommentDefault = { fg = palette.bright_blue },
				GitSignsAdd = { link = "GruvboxGreenSign" },
				GitSignsStagedAdd = { fg = palette.dark_green, bg = palette.dark1 },
				GitSignsChange = { link = "GruvboxAquaSign" },
				GitSignsStagedChange = { fg = palette.dark_aqua, bg = palette.dark1 },
				GitSignsDelete = { link = "GruvboxRedSign" },
				GitSignsStagedDelete = { fg = palette.dark_red, bg = palette.dark1 },
				GitSignsCurrentLineBlame = { link = "GruvboxFg4" },
				NeoTreeGitAdded = { link = "GruboxGreen" },
				NeoTreeGitModified = { link = "GruvboxAqua" },
				NeoTreeGitDelete = { link = "GruboxRed" },
				NeoTreeFloatTitle = { link = "TelescopePromptTitle" },
				NeoTreeTabActive = { fg = palette.dark0, bg = palette.bright_blue },
				NeoTreeTabInactive = { fg = palette.light4, bg = palette.dark2 },
				NeoTreeTabSeparatorActive = { link = "NeoTreeTabActive" },
				NeoTreeTabSeparatorInactive = { link = "NeoTreeTabInactive" },
				WhichKey = { fg = palette.bright_aqua, bold = true },
				WhichKeyDesc = { fg = palette.light1 },
				WhichKeyGroup = { fg = palette.neutral_blue, bold = true },
			},
		})

		-- Load the colorscheme
		vim.cmd.colorscheme("gruvbox")
	end,
}
