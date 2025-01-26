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
			vim.fn.sign_define(hl_sign, { text = icon, texthl = hl_sign })
		end

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP:" .. desc })
				end

				map("gd", vim.lsp.buf.definition, "Goto definition")
				map("gr", require("telescope.builtin").lsp_references, "Goto references")
				map("gI", require("telescope.builtin").lsp_implementations, "Goto implementation")
				map("<leader>D", vim.lsp.buf.type_definition, "Type definition")
				map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "Document symbols")
				map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace symbols")

				vim.keymap.set("n", "<leader>rn", function()
					return ":IncRename " .. vim.fn.expand("<cword>")
				end, { buffer = event.buf, expr = true, desc = "Rename" })

				-- TODO: Do we need this to work in visal mode?
				vim.keymap.set(
					{ "v", "n" },
					"<leader>ca",
					vim.lsp.buf.code_action,
					{ buffer = event.buf, desc = "Code actions", remap = true }
				)

				-- Signature help
				map("K", vim.lsp.buf.hover, "Hover Documentation")
				map("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

				-- Lesser used LSP functionality
				map("gD", vim.lsp.buf.declaration, "Goto declaration")

				local client = vim.lsp.get_client_by_id(event.data.client_id)
				-- Turn of lsp based syntax highlighting
				if client then
					client.server_capabilities.semanticTokensProvider = nil
					if client.server_capabilities.documentHighlightProvider then
						local highlight_augrup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augrup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augrup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = highlight_augrup, buffer = event2.buf })
							end,
						})
					end
				end
			end,
		})

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		-- TODO: Only do this is cmp_nvim_lsp is enabled
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
		capabilities.textDocument.colorProvider = {
			dynamicRegistration = true,
		}

		local handler = function(server_name)
			local server = require("tools").servers()[server_name] or {}
			server.capabilities = vim.tbl_deep_extend("force", capabilities, server.capabilities or {})
			server.handlers = handlers

			require("lspconfig")[server_name].setup(server)
		end

		for server, config in pairs(require("tools").servers()) do
			if config.system then
				handler(server)
			end
		end

		require("mason-lspconfig").setup({
			handlers = { handler },
		})
	end,
}
