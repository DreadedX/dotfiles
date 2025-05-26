-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "YankHighlight" })
	end,
	group = highlight_group,
	pattern = "*",
})

-- show cursor line only in active window
local cursor_group = vim.api.nvim_create_augroup("ActiveCursor", { clear = true })
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
	callback = function()
		local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
		if ok and cl then
			vim.wo.cursorline = true
			vim.api.nvim_win_del_var(0, "auto-cursorline")
		end
	end,
	group = cursor_group,
	pattern = "*",
})
vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
	callback = function()
		local cl = vim.wo.cursorline
		if cl then
			vim.api.nvim_win_set_var(0, "auto-cursorline", cl)
			vim.wo.cursorline = false
		end
	end,
	group = cursor_group,
	pattern = "*",
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
