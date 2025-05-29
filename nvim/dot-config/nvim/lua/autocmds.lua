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

local group = vim.api.nvim_create_augroup("lsp-attach", { clear = true })
-- Setup lsp keybindings
vim.api.nvim_create_autocmd("LspAttach", {
	group = group,
	callback = function(event)
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
		end

		-- Symbols
		map("grD", vim.lsp.buf.declaration, "Goto declaration")

		local has_telescope, telescope = pcall(require, "telescope.builtin")
		if has_telescope then
			map("grd", telescope.lsp_definitions, "Goto definition")

			map("grt", telescope.lsp_type_definitions, "Type definition")

			map("grr", telescope.lsp_references, "Goto references")
			map("gri", telescope.lsp_implementations, "Goto implementation")
			map("gO", telescope.lsp_document_symbols, "Document symbols")
			map("gW", telescope.lsp_dynamic_workspace_symbols, "Workspace symbols")
		end

		-- Diagnostics
		map("[d", function()
			vim.diagnostic.jump({ count = -1 })
		end, "Go to previous diagnostic message")
		map("]d", function()
			vim.diagnostic.jump({ count = 1 })
		end, "Go to next diagnostic message")
		map("<leader>e", vim.diagnostic.open_float, "Open floating diagnostic message")

		-- Helpers
		vim.keymap.set("n", "grn", function()
			return ":IncRename " .. vim.fn.expand("<cword>")
		end, { buffer = event.buf, expr = true, desc = "Rename" })
		map("gra", vim.lsp.buf.code_action, "Code actions", { "n", "x" })

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "Inlay hints")
		end
	end,
})

-- Setup cursor hover symbol highlight
vim.api.nvim_create_autocmd("LspAttach", {
	group = group,
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

-- Disable lsp based syntax highlighting
vim.api.nvim_create_autocmd("LspAttach", {
	group = group,
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client.server_capabilities.semanticTokensProvider then
			client.server_capabilities.semanticTokensProvider = nil
		end
	end,
})
