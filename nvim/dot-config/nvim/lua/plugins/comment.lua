-- https://github.com/numToStr/Comment.nvim
--- @module "lazy"
--- @type LazySpec
return {
	"numToStr/Comment.nvim",
	event = "VeryLazy",
	--- @module "Comment"
	--- @type CommentConfig
	opts = {
		toggler = {
			block = "gBc",
		},
		opleader = {
			block = "gB",
		},
	},
}
