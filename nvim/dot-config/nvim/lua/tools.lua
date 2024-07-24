local tools = {}

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
tools.servers = {
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
				-- schemas = require("schemastore").json.schemas(),
			},
		},
	},
	yamlls = {
		settings = {
			yaml = {
				schemaStore = {
					enable = false,
					url = "",
				},
				-- schemas = require("schemastore").yaml.schemas(),
			},
		},
	},
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
