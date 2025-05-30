-- https://github.com/nvim-treesitter/nvim-treesitter
--- @module "lazy"
--- @type LazySpec
return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter-textobjects", branch = "master" },
			{ "windwp/nvim-ts-autotag", opts = {} },
		},
		lazy = false,
		branch = "master",
		build = ":TSUpdate",
		main = "nvim-treesitter.configs",
		--- @module "nvim-treesitter"
		--- @type TSConfig
		opts = {
			ensure_installed = {
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
			},

			highlight = { enable = true },
			indent = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<M-o>",
					node_incremental = "<M-o>",
					node_decremental = "<M-i>",
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						-- ["ac"] = "@class.outer",
						-- ["ic"] = "@class.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]a"] = "@parameter.inner",
						["]f"] = "@function.outer",
						["]c"] = "@class.outer",
					},
					goto_next_end = {
						["]A"] = "@parameter.inner",
						["]F"] = "@function.outer",
						["]c"] = "@class.outer",
					},
					goto_previous_start = {
						["[a"] = "@parameter.inner",
						["[f"] = "@function.outer",
						["[c"] = "@class.outer",
					},
					goto_previous_end = {
						["[A"] = "@parameter.inner",
						["[F"] = "@function.outer",
						["[c"] = "@class.outer",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>a"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>A"] = "@parameter.inner",
					},
				},
			},
		},
	},
}
