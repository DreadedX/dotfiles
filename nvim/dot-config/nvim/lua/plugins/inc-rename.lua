-- https://github.com/smjonas/inc-rename.nvim
--- @module "lazy"
--- @type LazySpec
return {
	"smjonas/inc-rename.nvim",
	cmd = "IncRename",
	-- We can't load on just the command otherwise the preview does not work
	event = "LspAttach",
	--- @module "inc_rename"
	--- @type inc_rename.UserConfig
	opts = {
		preview_empty_name = true,
	},
}
