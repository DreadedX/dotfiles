local M = {}

local api = vim.api
local uri = require("kubernetes").yamlls_schema()

local schema = {
	name = "Kubernetes",
	uri = uri,
}

M.match = function(bufnr)
	local lines = api.nvim_buf_get_lines(bufnr, 0, -1, false)
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
			return schema
		end
	end
end

M.handles = function()
	return { schema }
end

return M
