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
				IncSearch = { fg = colors.aqua },
				Search = { fg = colors.aqua },
				NormalFloat = { bg = colors.bg0 },
				FloatBorder = { fg = colors.bg4 },
				TelescopePromptTitle = { fg = colors.fg4 },
				TelescopePromptBorder = { fg = colors.bg4 },
				TelescopePromptPrefix = { fg = colors.red },
				TelescopePreviewTitle = { fg = colors.fg4 },
				TelescopePreviewBorder = { fg = colors.bg4 },
				TelescopeResultsTitle = { fg = colors.fg4 },
				TelescopeResultsBorder = { fg = colors.bg4 },
				TelescopeMatching = { fg = colors.aqua, bold = true },
				TelescopeSelection = { fg = colors.blue },
				TelescopeSelectionCaret = { fg = colors.red },
			},
		})

		vim.cmd.colorscheme("gruvbox")
	end,
}
