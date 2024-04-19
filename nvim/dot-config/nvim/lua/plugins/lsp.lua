return {
	-- LSP Configuration & Plugins
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		-- Some of the lsp keybindings rely on telescope
		"nvim-telescope/telescope.nvim",
		-- Set capabilities from cmp
		"hrsh7th/cmp-nvim-lsp",

		-- Additional lua configuration, makes nvim stuff amazing!
		{ "folke/neodev.nvim", opts = {} },

		-- Add document color
		"mrshmllow/document-color.nvim",

		"b0o/schemastore.nvim",

		-- Rename with immediate visual feedback
	},
	config = function()
		local border = require("symbols.window").border

		-- Set borders
		local handlers = {
			["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
			["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
		}

		require("lspconfig.ui.windows").default_options = {
			border = border,
		}

		vim.diagnostic.config({
			severity_sort = true,
		})

		-- Create the signs for diagnostic symbols
		local diagnostic = require("symbols.diagnostic")
		local signs = {
			Error = diagnostic.error,
			Warn = diagnostic.warn,
			Hint = diagnostic.hint,
			Info = diagnostic.info,
		}
		for type, icon in pairs(signs) do
			local hl_sign = "DiagnosticSign" .. type
			local hl_text = "Diagnostic" .. type
			vim.fn.sign_define(hl_sign, { text = icon, texthl = hl_sign, numhl = hl_text })
		end

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("LspAttach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP:" .. desc })
				end

				map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
				map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
				map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
				map("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
				map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]symbols")
				map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]symbols")

				vim.keymap.set("n", "<leader>rn", function()
					return ":IncRename " .. vim.fn.expand("<cword>")
				end, { buffer = event.buf, expr = true, desc = "LSP: [R]e[N]ame" })

				-- TODO: Do we need this to work in visal mode?
				vim.keymap.set(
					{ "v", "n" },
					"<leader>ca",
					vim.lsp.buf.code_action,
					{ buffer = event.buf, desc = "LSP: [C]ode [A]ction", remap = true }
				)

				-- Signature help
				map("K", vim.lsp.buf.hover, "Hover Documentation")
				map("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

				-- Lesser used LSP functionality
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

				local client = vim.lsp.get_client_by_id(event.data.client_id)
				-- Turn of lsp based syntax highlighting
				client.server_capabilities.semanticTokensProvider = nil
				if client and client.server_capabilities.documentHighlightProvider then
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						callback = vim.lsp.buf.clear_references,
					})
				end
			end,
		})

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		-- TODO: Only do this is cmp_nvim_lsp is enabled
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
		capabilities.textDocument.colorProvider = {
			dynamicRegistration = true,
		}

		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = require("tools").servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", capabilities, server.capabilities or {})
					server.handlers = handlers

					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
