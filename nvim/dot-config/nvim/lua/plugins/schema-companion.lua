local kubernetes = {}
kubernetes.name = "Kubernetes"

---@type schema_companion.MatcherMatchFn
kubernetes.match = function(bufnr)
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	local kind = false
	local api_version = false

	for _, line in ipairs(lines) do
		if kind or vim.regex("^kind: .*$"):match_str(line) then
			kind = true
		end

		if api_version or vim.regex("^apiVersion: .*$"):match_str(line) then
			api_version = true
		end

		if kind and api_version then
			return {
				name = "Kubernetes",
				uri = require("kubernetes").yamlls_schema(),
			}
		end
	end

	return nil
end

return {
	"cenk1cenk2/schema-companion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"diogo464/kubernetes.nvim",
	},
	config = function()
		require("schema-companion").setup({
			enable_telescope = true,
			matchers = {
				kubernetes,
			},
			schemas = {},
		})

		-- TODO: Set on lsp attach with filetype yaml?
		vim.keymap.set(
			"n",
			"<leader>ss",
			require("telescope").extensions.schema_companion.select_schema,
			{ desc = "Select schema" }
		)

		vim.lsp.config(
			"yamlls",
			require("schema-companion").setup_client({
				single_file_support = true,
				settings = {
					yaml = {},
				},
			})
		)
	end,
}
