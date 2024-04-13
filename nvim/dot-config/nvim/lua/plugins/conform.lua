-- https://github.com/stevearc/conform.nvim
local slow_format_filetypes = {}
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
			desc = "[F]ormat buffer",
		},
	},
	opts = {
		-- TODO: Automate installing these using e.g. mason
		formatters_by_ft = {
			c = { "clang-format" },
			cpp = { "clang-format" },
			go = { "goimports", "gofmt" },
			python = { "ruff_format" },
			rust = { "rustfmt" },
			javascript = { { "prettierd", "prettier" } },
			typescript = { { "prettierd", "prettier" } },
			typescriptreact = { { "prettierd", "prettier" } },
			css = { { "prettierd", "prettier" } },
			markdown = { { "prettierd", "prettier" } },
			lua = { "stylua" },
			json = { "jq" },
			yaml = { { "prettierd", "prettier" } },
			toml = { "taplo" },
			cmake = { "cmake_format" },
			-- ["*"] = { "codespell" },
			["_"] = { "trim_whitespace", "trim_newlines" },
		},
		format_on_save = function(bufnr)
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end
			if slow_format_filetypes[vim.bo[bufnr].filetype] then
				return
			end
			local function on_format(err)
				if err and err:match("timeout$") then
					slow_format_filetypes[vim.bo[bufnr].filetype] = true
				end
			end
			return { timeout_ms = 200, lsp_fallback = true }, on_format
		end,
		format_after_save = function(bufnr)
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end
			if not slow_format_filetypes[vim.bo[bufnr].filetype] then
				return
			end
			return { lsp_fallback = true }
		end,
		notify_on_error = true,
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
