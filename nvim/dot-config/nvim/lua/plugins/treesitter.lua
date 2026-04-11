-- https://github.com/nvim-treesitter/nvim-treesitter
--- @module "lazy"
--- @type LazySpec
return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		branch = "main",
		build = ":TSUpdate",
		-- main = "nvim-treesitter.configs",
		init = function()
			vim.wo.foldmethod = "expr"
			vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

			require("nvim-treesitter").install({
				"c",
				"cpp",
				"go",
				"lua",
				"python",
				"rust",
				"tsx",
				"typescript",
				"vimdoc",
				"vim",
				"markdown",
				"markdown_inline",
				"bash",
				"sql",
				"xml",
				"cmake",
				"json",
				"yaml",
			})
		end,
	},
}
