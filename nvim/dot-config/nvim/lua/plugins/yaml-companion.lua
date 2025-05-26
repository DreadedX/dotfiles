return {
	"someone-stole-my-name/yaml-companion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"nvim-telescope/telescope.nvim",
		"diogo464/kubernetes.nvim",
	},
	config = function()
		require("telescope").load_extension("yaml_schema")

		vim.lsp.config("yamlls", require("yaml-companion").setup({
			builtin_matchers = {
				kubernetes = { enabled = false },
				kubernetes_custom = { enabled = true },
			},
		}))
	end,
}
