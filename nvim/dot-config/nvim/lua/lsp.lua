local diagnostic = require("symbols.diagnostic")
local methods = vim.lsp.protocol.Methods

local map = function(keys, func, desc, mode, bufnr)
	mode = mode or "n"
	vim.keymap.set(mode, keys, func, { desc = desc, buffer = bufnr })
end

-- General keymaps
map("[d", function()
	vim.diagnostic.jump({ count = -1 })
end, "Go to previous diagnostic message")
map("]d", function()
	vim.diagnostic.jump({ count = 1 })
end, "Go to next diagnostic message")

map("[e", function()
	vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
end, "Go to previous error message")
map("]e", function()
	vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
end, "Go to next error message")

map("<leader>e", vim.diagnostic.open_float, "Open floating diagnostic message")

map("<leader>th", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, "Toggle inlay hints")

map("gra", function()
	require("actions-preview").code_actions()
end, "Code actions", { "n", "x" })
map("grD", vim.lsp.buf.declaration, "Goto declaration")
map("grd", function()
	require("telescope.builtin").lsp_definitions({ jump_type = "never" })
end, "Goto definition")

map("grt", function()
	require("telescope.builtin").lsp_type_definitions()
end, "Type definition")
map("grr", function()
	require("telescope.builtin").lsp_references()
end, "Goto references")
map("gri", function()
	require("telescope.builtin").lsp_implementations()
end, "Goto implementation")

map("<leader>ss", function()
	require("telescope.builtin").lsp_document_symbols()
end, "Document symbols")
map("<leader>sS", function()
	require("telescope.builtin").lsp_dynamic_workspace_symbols()
end, "Workspace symbols")

-- Provide a placeholder rename keymap, otherwise the rename appears to works until you hit enter at which point it will fail
map("grn", function()
	vim.api.nvim_echo({ { "Rename are not available in current buffer" } }, true, { err = true })
end, "Rename")

---@param client vim.lsp.Client
---@param bufnr integer
local function on_attach(client, bufnr)
	-- Setup actual rename keymap if it is available
	if client:supports_method(methods.textDocument_rename, bufnr) then
		vim.keymap.set("n", "grn", function()
			return ":IncRename " .. vim.fn.expand("<cword>")
		end, { buffer = bufnr, expr = true, desc = "Rename" })
	end

	-- Disable lsp based syntax highlighting, I don't like it
	-- TODO: Switch to this once it is available
	-- vim.lsp.document_color.enable(false, bufnr)
	if client.server_capabilities.semanticTokensProvider then
		client.server_capabilities.semanticTokensProvider = nil
	end

	-- Highlight references under cursor
	if client:supports_method(methods.textDocument_documentHighlight) then
		local lsp_hover_hl = vim.api.nvim_create_augroup("LspHoverHighlight", { clear = false })
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			buffer = bufnr,
			group = lsp_hover_hl,
			callback = vim.lsp.buf.document_highlight,
		})

		vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
			buffer = bufnr,
			group = lsp_hover_hl,
			callback = vim.lsp.buf.clear_references,
		})
	end
end

vim.diagnostic.config({
	severity_sort = true,
	signs = {
		numhl = {
			[vim.diagnostic.severity.ERROR] = "DiagnosticNumError",
			[vim.diagnostic.severity.WARN] = "DiagnosticNumWarn",
			[vim.diagnostic.severity.HINT] = "DiagnosticNumHint",
			[vim.diagnostic.severity.INFO] = "DiagnosticNumInfo",
		},
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "",
			[vim.diagnostic.severity.INFO] = "",
		},
	},
	float = {
		severity_sort = false,
		header = "",
		suffix = function(d)
			local code = d.code and string.format(" (%s)", d.code) or ""

			return string.format("%s [%s]", code, d.source), "NormalFloat"
		end,
	},
	virtual_text = {
		prefix = function(d)
			return diagnostic[d.severity]
		end,
		virt_text_pos = "eol_right_align",
	},
})

local register_capability = vim.lsp.handlers[methods.client_registerCapability]
vim.lsp.handlers[methods.client_registerCapability] = function(err, res, ctx)
	local client = vim.lsp.get_client_by_id(ctx.client_id)
	if not client then
		return
	end

	on_attach(client, vim.api.nvim_get_current_buf())

	return register_capability(err, res, ctx)
end

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "Configure LSP keymaps",
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client then
			return
		end

		on_attach(client, args.buf)
	end,
})

-- Manually enable rust analyzer, if installed
if vim.fn.executable("rust_analyzer") then
	vim.lsp.enable("rust_analyzer")
end
