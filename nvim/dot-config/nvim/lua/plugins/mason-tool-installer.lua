--- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
--- @module "lazy"
--- @type LazySpec
return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	event = "VeryLazy",
	dependencies = {
		"mason-org/mason.nvim",
	},
	config = function()
		local lsp = require("tools.lsp")

		-- Convert lsp entries to consistent format
		local tools = {}
		for _, tool in pairs(lsp) do
			if type(tool) == "table" then
				local name = tool[1]
				local entry = {}

				-- Make a copy and strip out name and lsp config
				for k, v in pairs(tool) do
					if k ~= 1 and k ~= 2 then
						entry[k] = v
					end
				end

				tools[name] = entry
			else
				tools[tool] = {}
			end
		end

		-- Convert formatters to same format and merge on top of the lsps
		local formatters_by_ft = require("conform").formatters_by_ft
		local mapping = require("mason-conform.mapping")
		for _, formatter in pairs(formatters_by_ft) do
			if type(formatter) == "table" then
				for _, tool in ipairs(formatter) do
					local entry = {}
					local name = nil
					if type(tool) == "table" then
						name = mapping.conform_to_package[tool[1]]

						-- Make a copy and strip out name
						for k, v in pairs(tool) do
							if k ~= 1 then
								entry[k] = v
							end
						end
					else
						name = mapping.conform_to_package[tool]
					end

					if name ~= nil then
						tools[name] = vim.tbl_extend("error", tools[name] or {}, entry)
					end
				end
			end
		end

		local ensure_installed = vim.iter(tools)
			:map(function(name, tool)
				if type(tool) == "table" then
					if tool.system then
						return nil
					end

					local entry = {
						[1] = name,
					}

					for k, v in pairs(tool) do
						entry[k] = v
					end

					return entry
				end
				return tool
			end)
			:totable()

		require("mason-tool-installer").setup({
			ensure_installed = ensure_installed,
			auto_update = true,
			debounde_hours = 24,
		})
	end,
}
