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
	change_detection = {
		notify = false,
	},
	rocks = {
		enabled = false,
	},
	ui = {
		border = require("symbols.window").border,
		backdrop = 100,
	},
})

local lsp = require("tools.lsp")
for _, tool in pairs(lsp) do
	if type(tool) == "table" then
		local name = tool[1]

		-- Apply additional config if specified
		local config = tool[2]
		if config ~= nil then
			vim.lsp.config(name, config)
		end

		-- System LSP are not managed by mason and need to be enabled manually
		if
			(type(tool.system) == "boolean" and tool.system and vim.fn.executable(name) > 0)
			or (type(tool.system) == "string" and vim.fn.executable(tool.system) > 0)
		then
			vim.lsp.enable(name)
		end
	end
end
