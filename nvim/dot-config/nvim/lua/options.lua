local diagnostic = require("symbols.diagnostic")
local border = require("symbols.window").border

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = "unnamedplus"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
-- vim.o.completeopt = "menuone,noselect"

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Default tab settings
-- Tab settings are automatically detected by vim-sleuth
-- Can be overridden by .editorconfig and modeline
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = false
vim.o.smarttab = true

-- Ask for confirmation instead of failing
vim.o.confirm = true

-- Turn on cursorline
vim.o.cursorline = true

-- Don't show mode, powerline already shows it
vim.o.showmode = false

-- Minimum number of screen lines above and below the cursor
vim.o.scrolloff = 10

-- Highlight tabs and trailing whitespace
vim.o.listchars = "trail:~,tab:¦⁃,nbsp:␣"
vim.o.list = true

-- Fold settings
vim.o.foldlevelstart = 99

-- LSP config
vim.diagnostic.config({
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = diagnostic.error,
			[vim.diagnostic.severity.WARN] = diagnostic.warn,
			[vim.diagnostic.severity.HINT] = diagnostic.hint,
			[vim.diagnostic.severity.INFO] = diagnostic.info,
		},
	},
	virtual_text = {
		virt_text_pos = "eol_right_align",
		format = function(d)
			return ("%s [%s]"):format(d.message, d.source)
		end,
	},
})
