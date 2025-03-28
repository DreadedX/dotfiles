local tools = {}

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
tools.servers = function()
	return {
		clangd = {
			cmd = { "clangd", "--offset-encoding=utf-16", "--clang-tidy" },
		},
		gopls = {},
		pyright = {},
		rust_analyzer = {
			system = true,
			settings = {
				["rust-analyzer"] = {
					check = {
						command = "clippy",
					},
				},
			},
		},
		lua_ls = {
			settings = {
				Lua = {
					workspace = { checkThirdParty = false },
					telemetry = { enable = false },
				},
			},
		},
		jsonls = {
			settings = {
				json = {
					validate = { enable = true },
					schemas = require("schemastore").json.schemas(),
				},
			},
		},
		yamlls = require("yaml-companion").setup({
			builtin_matchers = {
				kubernetes = { enabled = false },
				kubernetes_custom = { enabled = true },
			},
		}),
		taplo = {},
		neocmake = {},
		nil_ls = {
			system = true,
		},
		typos_lsp = {
			init_options = {
				diagnosticSeverity = "Hint",
			},
		},
	}
end

-- https://github.com/stevearc/conform.nvim
tools.formatters = require("util.conform").assign_formatters({
	{ { "c", "cpp" }, { "clang-format" } },
	go = { "goimports", "gofmt" },
	python = { "ruff_format" },
	rust = { "rustfmt" },
	{
		{ "javascript", "typescript", "typescriptreact", "javascriptreact", "css", "markdown", "yaml" },
		{ "prettierd" },
	},
	lua = { "stylua" },
	json = { "jq" },
	toml = { "taplo" },
	nix = { "nixfmt" },
	-- ["*"] = { "injected" },
	["_"] = { "trim_whitespace", "trim_newlines" },
})

-- https://mason-registry.dev/registry/list
tools.extra = {
	"cpptools",
}

return tools
