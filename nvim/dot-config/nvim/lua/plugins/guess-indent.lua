-- https://github.com/NMAC427/guess-indent.nvim
--- @module "lazy"
--- @type LazySpec
return {
	"NMAC427/guess-indent.nvim",
	cmd = "GuessIndent",
	event = { "BufReadPre" },
	--- @module "guess-indent"
	--- @type GuessIndentConfig
	opts = {},
}
