-- Symbols to use for diagnostics
return {
	-- LSP Status symbols
	[vim.diagnostic.severity.ERROR] = " ",
	[vim.diagnostic.severity.WARN] = " ",
	[vim.diagnostic.severity.INFO] = " ",
	[vim.diagnostic.severity.HINT] = "󰌵",
	error = " ",
	warn = " ",
	info = " ",
	hint = "󰌵",
	-- Comment type symbols
	bug = "󰃤",
	todo = "",
	hack = "",
	performance = "",
	note = "󰙏",
	test = "󰙨",
}
