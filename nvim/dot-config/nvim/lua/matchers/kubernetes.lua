---@class schema_companion.Source
local M = {}

M.name = "Kubernetes"

M.config = {}

---@param config {}
---@return schema_companion.Source
function M.setup(config)
	setmetatable(M, {})
	M.config = vim.tbl_deep_extend("force", {}, M.config, config)

	return M
end

function M:match(_, bufnr)
	local resources = {}

	local current = {}
	for _, line in pairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) do
		local _, _, group, version = line:find([[^apiVersion:%s*["']?([^%s"'/]*)/?([^%s"']*)]])
		local _, _, kind = line:find([[^kind:%s*["']?([^%s"'/]*)]])

		if group and group ~= "" then
			current.group = group
		end
		if version and version ~= "" then
			current.version = version
		end
		if kind and kind ~= "" then
			current.kind = kind
		end

		if current.group and current.kind then
			table.insert(resources, current)
			current = {}
		end
	end

	local schemas = {}
	for _, resource in pairs(resources) do
		local api = resource.version and ("%s/%s"):format(resource.group, resource.version) or resource.group
		local schema = {
			name = ("%s@%s"):format(resource.kind, api),
			source = M.name,
			uri = require("kubernetes").yamlls_schema(),
		}
		if schema then
			table.insert(schemas, schema)
		end
	end

	return schemas
end

return M
