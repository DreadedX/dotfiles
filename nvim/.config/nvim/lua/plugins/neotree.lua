-- https://github.com/nvim-neo-tree/neo-tree.nvim
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
return {
	'nvim-neo-tree/neo-tree.nvim',
	version = "v2.x",
	dependencies = {
		'nvim-lua/plenary.nvim',
		'MunifTanjim/nui.nvim',
	},
	cmd = { 'Neotree' },
	keys = {
		{ '<F2>', '<cmd>Neotree toggle reveal filesystem float<cr>', desc = 'Open floating Neo-tree window' },
	},
	config = function ()
		local symbols = require('constant.symbols');

		require('neo-tree').setup {
			close_if_last_window = true,
			enable_diagnostics = true,
			source_selector = {
				winbar = true,
			},
			default_component_configs = {
				icon = {
					folder_closed = symbols.fold.closed,
					folder_open = symbols.fold.open,
					folder_empty = symbols.fold.empty,
					default = symbols.file.icon,
				},
				modified = {
					symbol = symbols.file.modified,
				},
				name = {
					use_git_status_colors = false,
				},
				git_status = {
					symbols = symbols.git,
				}
			},
			filesystem = {
				filtered_items = {
					hide_dotfiles = false,
					hide_by_name = {
						".git"
					}
				},
				use_libuv_file_watcher = true,
			},
			window = {
				mappings = {
					["<C-c>"] = "close_window",
					["<esc>"] = "close_window",
				},
			},
			buffers = {
				window = {
					mappings = {
						["bd"] = nil,
						["<C-d>"] = "buffer_delete",
					},
				},
			},
		}
	end,
}
