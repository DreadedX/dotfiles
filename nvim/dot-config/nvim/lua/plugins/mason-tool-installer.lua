--- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
local ensure_installed = {
	-- LSP
	"typos_lsp",
	"clangd",
	"basedpyright",
	"lua_ls",
	{
		"gopls",
		condition = function()
			return vim.fn.executable("go") > 0
		end,
	},
	"jsonls",
	"yamlls",
	"taplo",
	"neocmake",
	-- Formatter
	"clang-format",
	"goimports",
	"ruff",
	"prettierd",
	"stylua",
	"jq",
}

--- @module "lazy"
--- @type LazySpec
return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	event = "VeryLazy",
	dependencies = {
		"mason-org/mason.nvim",
	},
	opts = {
		ensure_installed = ensure_installed,
		auto_update = true,
		debounde_hours = 24,
	},
}
