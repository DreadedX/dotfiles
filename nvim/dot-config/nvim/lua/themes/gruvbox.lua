-- https://github.com/ellisonleao/gruvbox.nvim
return {
	"ellisonleao/gruvbox.nvim",
	commit = "487598d979868224aff92cf8818195c1a60e5dfe", -- Commit before things start breaking
	priority = 1000,
	config = function()
		local config = require("gruvbox").config
		local colors = require("gruvbox.palette").get_base_colors(vim.o.background, config.contrast)

		require("gruvbox").setup({
			background = "dark",
			italic = {
				strings = false,
			},
			overrides = {
				YankHighlight = { fg = colors.blue, bg = colors.bg0, reverse = config.inverse },
				Search = { fg = colors.aqua },
				IncSearch = { link = "Search" },
				NormalFloat = { bg = colors.bg0 },
				FloatBorder = { fg = colors.bg4 },
				TelescopePromptTitle = { fg = colors.fg4 },
				TelescopePromptBorder = { link = "FloatBorder" },
				TelescopePromptPrefix = { fg = colors.red },
				TelescopePreviewTitle = { link = "TelescopePreviewTitle" },
				TelescopePreviewBorder = { link = "FloatBorder" },
				TelescopeResultsTitle = { link = "TelescopePreviewTitle" },
				TelescopeResultsBorder = { link = "FloatBorder" },
				TelescopeMatching = { fg = colors.aqua, bold = true },
				TelescopeSelection = { fg = colors.blue },
				TelescopeSelectionCaret = { link = "TelescopeSelection" },
				CmpItemAbbrMatch = { fg = colors.aqua, bold = true },
				CmpItemAbbrMatchFuzzy = { link = "CmpItemAbbrMatch" },
				CmpItemMenu = { fg = colors.bg2 },
				CmpItemKindFunction = { fg = colors.red },
				CmpSelection = { fg = colors.bg0, bg = colors.blue },
				LspReferenceText = { fg = colors.bg0, bg = colors.neutral_purple },
				LspReferenceRead = { link = "LspReferenceText" },
				LspReferenceWrite = { link = "LspReferenceText" },
			},
		})

		-- Load the colorscheme
		vim.cmd.colorscheme("gruvbox")
	end,
}
