local window = require("symbols.window")

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "YankHighlight" })
	end,
})

-- show cursor line only in active window
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
	callback = function()
		local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
		if ok and cl then
			vim.wo.cursorline = true
			vim.api.nvim_win_del_var(0, "auto-cursorline")
		end
	end,
})
vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
	callback = function()
		local cl = vim.wo.cursorline
		if cl then
			vim.api.nvim_win_set_var(0, "auto-cursorline", cl)
			vim.wo.cursorline = false
		end
	end,
})

-- Setup lsp keybindings
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		-- Symbols
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Goto definition" })
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Goto declaration" })
		vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "Type definition" })

		if pcall(require, "telescope") then
			vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, { desc = "Goto references" })
			vim.keymap.set(
				"n",
				"gI",
				require("telescope.builtin").lsp_implementations,
				{ desc = "Goto implementation" }
			)
			vim.keymap.set(
				"n",
				"<leader>ds",
				require("telescope.builtin").lsp_document_symbols,
				{ desc = "Document symbols" }
			)
			vim.keymap.set(
				"n",
				"<leader>ws",
				require("telescope.builtin").lsp_dynamic_workspace_symbols,
				{ desc = "Workspace symbols" }
			)
		end

		-- Diagnostics
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.jump({ count = -1 })
		end, { desc = "Go to previous diagnostic message" })
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.jump({ count = 1 })
		end, { desc = "Go to next diagnostic message" })
		-- vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
		vim.keymap.set("n", "<leader>e", function()
			if vim.diagnostic.config().virtual_lines then
				vim.diagnostic.config({ virtual_lines = false })
			else
				vim.diagnostic.config({
					virtual_lines = {
						current_line = true,
						format = vim.diagnostic.config().virtual_text.format,
					},
				})
			end
		end, { desc = "Show virtual diagnostic line" })

		-- Helpers
		vim.keymap.set("n", "<leader>rn", function()
			return ":IncRename " .. vim.fn.expand("<cword>")
		end, { buffer = event.buf, expr = true, desc = "Rename" })
		vim.keymap.set(
			"n",
			"<leader>ca",
			vim.lsp.buf.code_action,
			{ buffer = event.buf, desc = "Code actions", remap = true }
		)

		-- Documentation
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover({ border = window.border })
		end, { desc = "Hover Documentation" })
		-- vim.keymap.set("n", "<C-k>", function()
		-- 	vim.lsp.buf.signature_help({ border = border })
		-- end, { desc = "Signature Documentation" })
	end,
})

-- Setup cursor hover symbol highlight
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
			local lsp_hover_hl = vim.api.nvim_create_augroup("LspHoverHighlight", { clear = false })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = lsp_hover_hl,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = lsp_hover_hl,
				callback = vim.lsp.buf.clear_references,
			})

			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("LspHoverHighlightDetach", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = lsp_hover_hl, buffer = event2.buf })
				end,
			})
		end
	end,
})

-- Setup cursor hover symbol highlight
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client.server_capabilities.semanticTokensProvider then
			client.server_capabilities.semanticTokensProvider = nil
		end
	end,
})

--
vim.api.nvim_create_autocmd("CursorMoved", {
	callback = function()
		vim.diagnostic.config({ virtual_lines = false })
	end,
})

-- Auto install treesitter parser and start them
vim.api.nvim_create_autocmd("FileType", {
	desc = "Enable Treesitter",
	group = vim.api.nvim_create_augroup("enable_treesitter", {}),
	callback = function(event)
		local has_treesitter, treesitter = pcall(require, "nvim-treesitter")
		if has_treesitter then
			local language = vim.treesitter.language.get_lang(event.match)
			treesitter.install(language):await(function()
				if pcall(vim.treesitter.start) then
					-- Use Treesitter indentation and folds.
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					vim.wo.foldmethod = "expr"
					vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
				end
			end)
		end
	end,
})
