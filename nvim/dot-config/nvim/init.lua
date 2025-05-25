-- Basic vim config stuff
require("keymaps")
require("options")
require("autocmds")

-- Install lazy package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ import = "themes" },
	{ import = "plugins" },
}, {
	install = {
		colorscheme = {
			"gruvbox",
		},
	},
	rocks = {
		enabled = false,
	},
	ui = {
		border = require("symbols.window").border,
		backdrop = 100,
	},
})
