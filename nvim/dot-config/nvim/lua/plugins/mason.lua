return {
	{
		"williamboman/mason.nvim",
		opts = {
			ui = {
				border = require("symbols.window").border,
				height = 0.8,
			},
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		config = function()
			local tools = require("tools")
			local ensure_installed = vim.tbl_keys(tools.servers)
			ensure_installed =
				vim.list_extend(ensure_installed, require("util.mason").process_formatters(tools.formatters))
			ensure_installed = vim.list_extend(ensure_installed, tools.extra)

			require("mason-tool-installer").setup({
				ensure_installed = ensure_installed,
			})
		end,
	},
}
