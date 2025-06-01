-- https://github.com/nvim-telescope/telescope.nvim
local window = require("symbols.window")
--- @module "lazy"
--- @type LazySpec
return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = { "Telescope" },
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = function()
			return {
				pickers = {
					find_files = {
						hidden = true,
					},
				},
				defaults = {
					file_ignore_patterns = {
						".git/",
					},
					mappings = {
						n = {
							["<Tab>"] = "move_selection_worse",
							["<S-Tab>"] = "move_selection_better",
						},
						i = {
							["<Tab>"] = "move_selection_worse",
							["<S-Tab>"] = "move_selection_better",
						},
					},
					borderchars = window.borderchars,
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			}
		end,
		init = function()
			vim.keymap.set("n", "<leader>.", function()
				require("telescope.builtin").oldfiles()
			end, { desc = "Find recently opened files" })
			vim.keymap.set("n", "<leader>sb", function()
				require("telescope.builtin").buffers()
			end, { desc = "Buffers" })

			vim.keymap.set("n", "<leader>/", function()
				require("telescope.builtin").current_buffer_fuzzy_find({
					-- Show matches in the order they appear in the document
					sorting_strategy = "ascending",
				})
			end, { desc = "Fuzzily search in current buffer" })
			vim.keymap.set("n", "<leader>s/", function()
				require("telescope.builtin").live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "Grep in open files" })

			vim.keymap.set("n", "<leader><space>", function()
				require("telescope.builtin").find_files()
			end, { desc = "Find files" })
			vim.keymap.set("n", "<leader>sh", function()
				require("telescope.builtin").help_tags()
			end, { desc = "Help" })
			vim.keymap.set("n", "<leader>sw", function()
				require("telescope.builtin").grep_string({
					-- Show matches in the order they appear in the document
					sorting_strategy = "ascending",
				})
			end, { desc = "Current word" })
			vim.keymap.set("n", "<leader>sg", function()
				require("telescope.builtin").live_grep()
			end, { desc = "Grep" })
			vim.keymap.set("n", "<leader>sd", function()
				require("telescope.builtin").diagnostics()
			end, { desc = "Diagnostics" })
			vim.keymap.set("n", "<leader>sr", function()
				require("telescope.builtin").resume()
			end, { desc = "Resume" })
			vim.keymap.set("n", "<leader>sk", function()
				require("telescope.builtin").keymaps()
			end, { desc = "Keymaps" })
			vim.keymap.set("n", "<leader>sn", function()
				require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "Neovim files" })

			-- HACK: Workaround until new borders are fixed in telescope
			vim.api.nvim_create_autocmd("User", {
				pattern = "TelescopeFindPre",
				callback = function()
					vim.opt_local.winborder = "none"
					vim.api.nvim_create_autocmd("WinLeave", {
						once = true,
						callback = function()
							vim.opt_local.winborder = window.border
						end,
					})
				end,
			})
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("telescope").load_extension("ui-select")
		end,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		build = "make",
		cond = function()
			return vim.fn.executable("make") == 1
		end,
		config = function()
			require("telescope").load_extension("fzf")
		end,
	},
}
