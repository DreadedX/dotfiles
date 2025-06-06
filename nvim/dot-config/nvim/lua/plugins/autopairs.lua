-- https://github.com/altermo/ultimate-autopair.nvim
--- @module "lazy"
--- @type LazySpec
return {
	"altermo/ultimate-autopair.nvim",
	event = { "InsertEnter", "CmdlineEnter" },
	branch = "v0.6",
	--- @module "ultimate-autopair"
	--- @type prof.def.conf
	opts = {
		fastwarp = {
			faster = true,
		},
		-- Fix single quotes in rust
		config_internal_pairs = {
			{
				"'",
				"'",
				multiline = false,
				nft = {},
				suround = true,
				cond = function(fn)
					if fn.get_ft() ~= "rust" then
						return true
					end
					return not fn.in_node({ "bounded_type", "reference_type", "type_arguments", "type_parameters" })
				end,
			},
		},
	},
}
