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
			local ensure_installed = vim.tbl_keys(vim.tbl_map(function(tool)
				if tool.system then
					return nil
				else
					return tool
				end
			end, tools.servers()))
			ensure_installed = vim.list_extend(ensure_installed, tools.extra)

			require("mason-tool-installer").setup({
				ensure_installed = ensure_installed,
				auto_update = true,
			})
		end,
	},
	{
		"zapling/mason-conform.nvim",
		opts = {},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"stevearc/conform.nvim",
		},
	},
}
