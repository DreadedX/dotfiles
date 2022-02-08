local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

require('packer').startup(function()
	use 'antoinemadec/FixCursorHold.nvim'
	use 'wbthomason/packer.nvim'

	use 'gruvbox-community/gruvbox'
	use 'tomasiser/vim-code-dark'
	use 'bling/vim-airline'

	use 'Raimondi/delimitMate'
	-- use 'scrooloose/nerdtree'
	use {
		'kyazdani42/nvim-tree.lua',
		requires = {
			'kyazdani42/nvim-web-devicons', -- optional, for file icon
		},
		config = function() require'nvim-tree'.setup {
			auto_close = true,
		} end
	}
	use 'tpope/vim-commentary'
	use 'tpope/vim-surround'
	use 'christoomey/vim-tmux-navigator'
	use 'tpope/vim-dispatch'
	use 'milkypostman/vim-togglelist'
	use 'moll/vim-bbye'
	use {
		'nvim-telescope/telescope.nvim',
		requires = { {'nvim-lua/plenary.nvim'} }
	}
	use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'
	use 'onsails/lspkind-nvim'
	use 'ray-x/lsp_signature.nvim'
	use {
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup {
				signs = {
					-- icons / text used for a diagnostic
					error = "error",
					warning = "warn",
					hint = "hint",
					information = "info"
				},
			}
		end
	}

	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
	use 'windwp/nvim-ts-autotag'
	use 'JoosepAlviste/nvim-ts-context-commentstring'

	use 'hrsh7th/cmp-vsnip'
	use 'hrsh7th/vim-vsnip'
	use "rafamadriz/friendly-snippets"
	
	use 'leafgarland/typescript-vim'
	use 'peitalin/vim-jsx-typescript'
end)

--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')

require "lsp_signature".setup({
	hint_enable = false,
	handler_opts = {
		border = "none"   -- double, rounded, single, shadow, none
	},
	padding = ' ',
})

require'nvim-tree'.setup()

-- nvim-cmp setup
local cmp = require 'cmp'

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup {
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = {
		['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
		['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
		['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
		['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif vim.fn["vsnip#available"](1) == 1 then
				feedkey("<Plug>(vsnip-expand-or-jump)", "")
			elseif has_words_before() then
				cmp.complete()
			else
				fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item()
			elseif vim.fn["vsnip#jumpable"](-1) == 1 then
				feedkey("<Plug>(vsnip-jump-prev)", "")
			end
		end, { "i", "s" }),
	},
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'vsnip' }, -- For vsnip users.
	}, {
		{ name = 'buffer' },
	})
}

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
	sources = {
		{ name = 'buffer' }
	}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})

cmp.setup({
	enabled = function()
		-- disable completion in comments
		local context = require 'cmp.config.context'
		-- keep command mode completion enabled when cursor is in a comment
		if vim.api.nvim_get_mode().mode == 'c' then
			return true
		else
			return not context.in_syntax_group("Comment")
		end
	end
})

-- lsp setup
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

vim.o.updatetime = 100

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

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

local servers = { 'clangd', 'tsserver', 'gopls', 'pylsp' }
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup {
		-- on_attach = my_custom_on_attach,
		capabilities = capabilities
	}
end

nvim_lsp.cssls.setup {
	capabilities = capabilities,
	cmd = {"vscode-css-languageserver", "--stdio"}
}

local lspkind = require('lspkind')
cmp.setup {
	formatting = {
		format = lspkind.cmp_format({
			with_text = true,
			menu = ({
				buffer = "[Buffer]",
				nvim_lsp = "[LSP]",
				luasnip = "[LuaSnip]",
				nvim_lua = "[Lua]",
				latex_symbols = "[Latex]",
			})
		}),
	},
	experimental = {
		ghost_text = true
	}
}

require'nvim-treesitter.configs'.setup {
	ensure_installed = "maintained",
}
require('nvim-ts-autotag').setup()
require'nvim-treesitter.configs'.setup {
	context_commentstring = {
		enable = true
	}
}

local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Set completeopt to have a better completion experience
-- vim.o.completeopt = 'menuone,noselect'
