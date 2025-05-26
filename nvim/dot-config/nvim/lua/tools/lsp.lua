return {
	{
		"rust_analyzer",
		{
			settings = {
				["rust-analyzer"] = {
					check = {
						command = "clippy",
					},
				},
			},
		},
		system = "rust-analyzer",
	},
	{ "typos_lsp", {
		init_options = {
			diagnosticSeverity = "Hint",
		},
	} },
	{ "clangd", {
		cmd = { "clangd", "--offset-encoding=utf-16", "--clang-tidy" },
	} },
	"basedpyright",
	{
		"lua_ls",
		{
			settings = {
				Lua = {
					workspace = { checkThirdParty = false },
					telemetry = { enable = false },
				},
			},
		},
	},
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
}
