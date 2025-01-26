-- https://github.com/nvim-telescope/telescope.nvim
-- TODO: Ensure installed ripgrep
return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
	},
	config = function()
		require("telescope").setup({

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
				borderchars = require("symbols.window").borderchars,
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})

		require("telescope").load_extension("fzf")
		require("telescope").load_extension("ui-select")

		vim.keymap.set("n", "<leader>.", require("telescope.builtin").oldfiles, { desc = "Find recently opened files" })
		vim.keymap.set("n", "<leader>sb", require("telescope.builtin").buffers, { desc = "Buffers" })

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

		vim.keymap.set("n", "<leader><space>", require("telescope.builtin").find_files, { desc = "Find files" })
		vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "Help" })
		vim.keymap.set("n", "<leader>sw", function()
			require("telescope.builtin").grep_string({
				-- Show matches in the order they appear in the document
				sorting_strategy = "ascending",
			})
		end, { desc = "Current word" })
		vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "Grep" })
		vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "Diagnostics" })
		vim.keymap.set("n", "<leader>sr", require("telescope.builtin").resume, { desc = "Resume" })
		vim.keymap.set("n", "<leader>sk", require("telescope.builtin").keymaps, { desc = "Keymaps" })
		vim.keymap.set("n", "<leader>sn", function()
			require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "Neovim files" })
	end,
}
