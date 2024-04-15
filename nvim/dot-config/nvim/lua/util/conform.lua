-- Helper function for assigning formatters to multiple languages at the same time
local M = {}

function M.assign_formatters(input)
	local table = {}
	for k, v in pairs(input) do
		if type(k) == "number" then
			for _, lang in pairs(v[1]) do
				table[lang] = v[2]
			end
		else
			table[k] = v
		end
	end
	return table
end

return M
