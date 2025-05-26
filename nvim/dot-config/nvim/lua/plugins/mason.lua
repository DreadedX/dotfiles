return {
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"mason-org/mason-lspconfig.nvim",
		},
		config = function()
			local lsp = require("tools.lsp")

			local ensure_installed = vim.tbl_values(vim.tbl_map(function(tool)
				if type(tool) == "table" then
					if not tool.system then
						return {
							tool[1],
							condition = tool.condition,
						}
					end
				else
					return tool
				end
				return nil
			end, lsp))

			require("mason-tool-installer").setup({
				ensure_installed = ensure_installed,
				auto_update = true,
			})
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
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
