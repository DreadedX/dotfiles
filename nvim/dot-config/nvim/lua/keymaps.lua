vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { noremap = true, silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Some nice adjustments
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

-- Clear search highlight by pressing esc
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "rust" },
	callback = function(args)
		local command = {
			rust = "cargo run",
		}
		vim.keymap.set("n", "<F5>", function()
			vim.system({ "tmux", "send-keys", "-t", ":shell", "c-u", command[args.match], "Enter" })
			vim.system({ "tmux", "select-window", "-t", ":shell" })
		end, { buffer = true })
	end,
})
