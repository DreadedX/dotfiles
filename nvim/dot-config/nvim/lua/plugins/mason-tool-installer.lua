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
	{
		"goimports",
		condition = function()
			return vim.fn.executable("go") > 0
		end,
	},
	"ruff",
	"prettier",
	"stylua",
	"eslint",
}

--- @module "lazy"
--- @type LazySpec
return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	dependencies = {
		"mason-org/mason.nvim",
	},
	event = "VeryLazy",
	opts = {
		ensure_installed = ensure_installed,
		auto_update = true,
	},
	config = function(_, opts)
		require("mason-tool-installer").setup(opts)

		-- VeryLazy happens _after_ VimEnter, so we have to manually call this
		require("mason-tool-installer").run_on_start()
	end,
}
