-- https://github.com/neovim/nvim-lspconfig
--- @module "lazy"
--- @type LazySpec
return {
	"neovim/nvim-lspconfig",
	cmd = { "LspInfo", "LspStart", "LspStop", "LspRestart" },
}
