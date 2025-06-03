-- https://github.com/nvim-neo-tree/neo-tree.nvim
local fold = require("symbols.fold")
local file = require("symbols.file")

--- @module "lazy"
--- @type LazySpec
return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	cmd = { "Neotree" },
	keys = {
		{ "<F2>", "<cmd>Neotree toggle reveal<cr>", desc = "Open floating Neo-tree window" },
	},
	-- netrw hijack does not work when lazy loading
	lazy = false,
	--- @module "neo-tree"
	--- @type neotree.Config
	opts = {
		close_if_last_window = true,
		popup_border_style = require("symbols.window").border,
		source_selector = {
			winbar = true,
			show_scrolled_off_parent_node = true,
			sources = {
				{
					source = "filesystem",
					display_name = " Files ",
				},
				{
					source = "buffers",
					display_name = " Buffers ",
				},
				{
					source = "git_status",
					display_name = " Git ",
				},
			},
			show_separator_on_edge = true,
		},
		default_component_configs = {
			diagnostics = {
				highlights = {
					hint = "DiagnosticHint",
					info = "DiagnosticInfo",
					warn = "DiagnosticWarn",
					error = "DiagnosticError",
				},
			},
			icon = {
				folder_closed = fold.closed,
				folder_open = fold.open,
				folder_empty = fold.empty,
				folder_empty_open = fold.open,
				default = file.icon,
			},
			modified = {
				symbol = file.modified,
			},
			name = {
				use_git_status_colors = false,
			},
			git_status = {
				symbols = require("symbols.git"),
			},
			type = {
				enabled = false,
			},
			last_modified = {
				enabled = false,
			},
			symlink_target = {
				enabled = true,
			},
		},
		filesystem = {
			follow_current_file = {
				enabled = true,
			},
			hijack_netrw_behavior = "open_current",
			use_libuv_file_watcher = true,
			scan_mode = "deep",
		},
		window = {
			popup = {
				title = function()
					return ""
				end,
			},
			position = "float",
			mappings = {
				["<C-c>"] = "close_window",
				["<esc>"] = "close_window",
				["<tab>"] = "next_source",
				["<S-tab>"] = "prev_source",
			},
		},
	},
}
