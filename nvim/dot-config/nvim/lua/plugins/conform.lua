-- https://github.com/stevearc/conform.nvim
local formatters_by_ft = {
	c = { "clang-format" },
	cpp = { "clang-format" },
	go = { "goimports" },
	python = { "ruff_organize_imports", "ruff_format" },
	rust = { "rustfmt" },
	javascript = { "prettier" },
	javascriptreact = { "prettier" },
	typescript = { "prettier" },
	typescriptreact = { "prettier" },
	css = { "prettier" },
	markdown = { "prettier" },
	yaml = { "prettier" },
	lua = { "stylua" },
	json = { "prettier" },
	toml = { "taplo" },
	-- ["*"] = { "injected" },
	["_"] = { "trim_whitespace", "trim_newlines" },
}

--- @module "lazy"
--- @type LazySpec
return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			-- Customize or remove this keymap to your liking
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	--- @module "conform"
	--- @type conform.setupOpts
	opts = {
		formatters_by_ft = formatters_by_ft,
		notify_on_error = false,
		format_on_save = function(bufnr)
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end
			--- @type conform.FormatOpts
			return { lsp_format = "fallback" }
		end,
	},
	init = function()
		vim.api.nvim_create_user_command("FormatDisable", function(args)
			if args.bang then
				-- FormatDisable! will disable formatting just for this buffer
				vim.b.disable_autoformat = true
			else
				vim.g.disable_autoformat = true
			end
		end, {
			desc = "Disable autoformat-on-save",
			bang = true,
		})

		vim.api.nvim_create_user_command("FormatEnable", function()
			vim.b.disable_autoformat = false
			vim.g.disable_autoformat = false
		end, {
			desc = "Re-enable autoformat-on-save",
		})
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
