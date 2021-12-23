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
	-- use 'ray-x/lsp_signature.nvim'
	
	use 'leafgarland/typescript-vim'
	use 'peitalin/vim-jsx-typescript'
	use 'cespare/vim-toml'
end)

--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

require('telescope').setup{ defaults = { file_ignore_patterns = { "node_module" } } }

local nvim_lsp = require('lspconfig')

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

-- Taken from: https://github.com/wookayin/dotfiles/blob/master/nvim/lua/config/lsp.lua
-- Makes it so the diagnostic popup does not keep overwriting other popups
vim.diagnostic.config({
	virtual_text = false,
	float = {
		focusable = false,   -- See neovim#16425
	},
})
_G.LspDiagnosticsShowPopup = function()
	return vim.diagnostic.open_float(0, {scope="cursor"})
end

-- Show diagnostics in a pop-up window on hover
_G.LspDiagnosticsPopupHandler = function()
  local current_cursor = vim.api.nvim_win_get_cursor(0)
  local last_popup_cursor = vim.w.lsp_diagnostics_last_cursor or {nil, nil}

  -- Show the popup diagnostics window,
  -- but only once for the current cursor location (unless moved afterwards).
  if not (current_cursor[1] == last_popup_cursor[1] and current_cursor[2] == last_popup_cursor[2]) then
    vim.w.lsp_diagnostics_last_cursor = current_cursor
    local _, winnr = _G.LspDiagnosticsShowPopup()
  end
end
vim.cmd [[
augroup LSPDiagnosticsOnHover
  autocmd!
  autocmd CursorHold *   lua _G.LspDiagnosticsPopupHandler()
augroup END
]]

vim.cmd [[autocmd CursorHoldI * lua vim.lsp.buf.signature_help()]]

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

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
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end,
		['<S-Tab>'] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
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
