local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

require('packer').startup(function()
	use 'wbthomason/packer.nvim'

	use 'gruvbox-community/gruvbox'
	use 'bling/vim-airline'

	use 'Raimondi/delimitMate'
	use 'alvan/vim-closetag'
	use 'scrooloose/nerdtree'
	-- use 'tomtom/tcomment_vim'
	use 'tpope/vim-commentary'
	use 'tpope/vim-surround'
	use 'christoomey/vim-tmux-navigator'
	use 'tpope/vim-dispatch'
	use 'milkypostman/vim-togglelist'
	use 'moll/vim-bbye'
	-- use { 'junegunn/fzf', run = './install --bin' }
	-- use 'junegunn/fzf.vim'
	-- use 'tpope/vim-fugitive'
	use 'ConradIrwin/vim-bracketed-paste'
	use {
		'nvim-telescope/telescope.nvim',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
	use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
	use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
	use 'hrsh7th/cmp-buffer' -- LSP source for buffer
	use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
	use 'L3MON4D3/LuaSnip' -- Snippets plugin
	use 'ray-x/lsp_signature.nvim'
	
	use 'leafgarland/typescript-vim'
	use 'peitalin/vim-jsx-typescript'
	use 'cespare/vim-toml'
end)

local nvim_lsp = require('lspconfig')

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		virtual_text = {
			spacing = 8,
		},
		signs = true,
		update_in_insert = false
	}
)

vim.o.updatetime = 250
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})]]

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'clangd', 'tsserver', 'gopls', 'pylsp' }
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup {
		-- on_attach = my_custom_on_attach,
		capabilities = capabilities
	}
end

vim.fn.sign_define("LspDiagnosticsSignError", { text="" })
vim.fn.sign_define("LspDiagnosticsSignWarning", { text="" })
vim.fn.sign_define("LspDiagnosticsSignInformation", { text="" })
vim.fn.sign_define("LspDiagnosticsSignHint", { text="" })

require 'lsp_signature'.setup({
	bind =  true,
	hint_enable = false,
	handler_opts = {
		border = "none"
	}
})

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
	mapping = {
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
		['<Tab>'] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
			else
				fallback()
			end
		end,
		['<S-Tab>'] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
			else
				fallback()
			end
		end,
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{ name = 'buffer' },
	},
}
