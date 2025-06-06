-- https://github.com/ellisonleao/gruvbox.nvim
--- @module "lazy"
--- @type LazySpec
return {
	"ellisonleao/gruvbox.nvim",
	priority = 1000,
	config = function(_, opts)
		require("gruvbox").setup(opts)

		-- Load the colorscheme
		vim.cmd.colorscheme("gruvbox")
	end,
	opts = function()
		local palette = require("gruvbox").palette

		return {
			background = "dark",
			italic = {
				strings = false,
			},
			overrides = {
				CursorLineNr = { fg = palette.light4, bg = palette.dark1, bold = true },
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
				BlinkCmpMenu = { fg = palette.dark2 },
				BlinkCmpMenuBorder = { fg = palette.dark4 },
				BlinkCmpDocBorder = { fg = palette.dark4 },
				BlinkCmpDocSeparator = { fg = palette.dark4 },
				BlinkCmpSignatureHelpBorder = { fg = palette.dark4 },
				BlinkCmpKindFunction = { fg = palette.bright_red },
				BlinkCmpMenuSelection = { fg = palette.dark0, bg = palette.bright_blue },
				LspReferenceText = { bg = palette.dark1 },
				LspReferenceRead = { link = "LspReferenceText" },
				LspReferenceWrite = { link = "LspReferenceText" },
				TodoCommentError = { fg = palette.bright_red },
				TodoCommentWarning = { fg = palette.bright_yellow },
				TodoCommentInfo = { fg = palette.light1 },
				TodoCommentHint = { fg = palette.bright_aqua },
				TodoCommentTest = { fg = palette.bright_purple },
				TodoCommentDefault = { fg = palette.bright_blue },
				GitSignsAdd = { fg = palette.bright_green, bold = true },
				GitSignsStagedAdd = { fg = palette.dark_green, bold = true },
				GitSignsChange = { fg = palette.bright_aqua, bold = true },
				GitSignsStagedChange = { fg = palette.dark_aqua, bold = true },
				GitSignsDelete = { fg = palette.bright_red, bold = true },
				GitSignsStagedDelete = { fg = palette.dark_red, bold = true },
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
				NeoTreeBufferNumber = { fg = palette.bright_green, bold = true },
				NeoTreeDirectoryName = { fg = palette.neutral_blue, bold = true },
				NeoTreeRootName = { fg = palette.neutral_blue, bold = true },
				NeoTreeDirectoryIcon = { fg = palette.neutral_blue },
				NeoTreeFileIcon = { fg = palette.light1 },
				NeoTreeFilterTerm = { fg = palette.bright_aqua, bold = true },
				NeoTreeSymbolicLinkTarget = { fg = palette.bright_aqua, bold = true },
				DiagnosticNumError = { fg = palette.dark0, bg = palette.bright_red, bold = true },
				DiagnosticNumWarn = { fg = palette.dark0, bg = palette.bright_yellow, bold = true },
				DiagnosticNumHint = { fg = palette.dark0, bg = palette.bright_aqua, bold = true },
				DiagnosticNumInfo = { fg = palette.dark0, bg = palette.bright_blue, bold = true },
				SnacksIndentScope = { fg = palette.light4 },
			},
		}
	end,
}
