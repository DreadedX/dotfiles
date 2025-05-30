-- https://github.com/toppair/peek.nvim
--- @module "lazy"
--- @type LazySpec
return {
	"toppair/peek.nvim",
	build = "deno task --quiet build:fast",
	cond = function()
		return vim.fn.executable("deno") == 1
	end,
	lazy = true,
	cmd = { "PeekOpen", "PeekClose" },
	init = function()
		vim.api.nvim_create_user_command("PeekOpen", function()
			require("peek").open()
		end, {})
		vim.api.nvim_create_user_command("PeekClose", function()
			require("peek").close()
		end, {})

		-- local augroup = vim.api.nvim_create_augroup('Peek', { clear = true })
		--
		-- -- Automatically open a markdown preview window
		-- vim.api.nvim_create_autocmd({ "FileType" }, {
		-- 	callback = function()
		-- 		require('peek').open()
		-- 	end,
		-- 	group = augroup,
		-- 	pattern = "markdown",
		-- })
	end,
	opts = {},
}
