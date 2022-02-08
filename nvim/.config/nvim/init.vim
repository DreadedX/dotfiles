let g:nvim_tree_show_icons = {
    \ 'git': 0,
    \ 'folders': 1,
    \ 'files': 0,
    \ 'folder_arrows': 0,
    \ }
let g:nvim_tree_icons = {
    \ 'folder': {
    \   'arrow_open': "",
    \   'arrow_closed': "",
    \   'default': "",
    \   'open': "",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "",
    \   'symlink_open': "",
    \   }
    \ }
lua require('plugins')

" Load vim config in current directory
silent! so .vimlocal

" DelimitMate
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
let delimitMate_balance_matchpairs = 1

" Theme
colorscheme gruvbox
set t_Co=256
set t_ZH=[3m
set t_ZR=[23m
set background=dark

" Ident
" set list lcs=tab:┃\ ,trail:·
set list lcs=tab:¦\ ,trail:·

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='gruvbox'
" let g:airline_theme='codedark'
let g:airline_section_z = '%3p%% %#__accent_bold#%4l%#__restore__#%#__accent_bold#/%L%#__restore__# :%3v'
let g:airline_section_warning = ''

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

let g:airline_symbols.dirty = " ±"
let g:airline_symbols.notexists = " "

" Preferences
syntax on
filetype plugin indent on
set smartindent
set number
set laststatus=2
set softtabstop=4
set tabstop=4
set shiftwidth=4
set noexpandtab
set mouse=n
set hidden
set updatetime=300
set noshowmode

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldnestmax=1
set foldlevel=20

" Keybindings
nnoremap <F2>    <cmd>NvimTreeToggle<cr>
nnoremap <M-h>   <cmd>TmuxNavigateLeft<cr>
nnoremap <M-j>   <cmd>TmuxNavigateDown<cr>
nnoremap <M-k>   <cmd>TmuxNavigateUp<cr>
nnoremap <M-l>   <cmd>TmuxNavigateRight<cr>
nnoremap <tab>   <cmd>bn<cr>
nnoremap <S-tab> <cmd>bp<cr>
nnoremap <C-b>   <cmd>Bdelete<cr>
nnoremap <F3>    <cmd>TroubleToggle workspace_diagnostics<cr>
nnoremap <F4>    <cmd>call ToggleQuickfixList()<cr>
nnoremap <F1>    <cmd>noh<cr>
map <S-j>   10j
map <S-k>   10k

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>lc <cmd>Telescope lsp_code_actions<cr>
nnoremap <leader>ls <cmd>Telescope lsp_document_symbols<cr>
nnoremap <leader>ln <cmd>lua vim.lsp.diagnostic.goto_next()<cr>
nnoremap <leader>lp <cmd>lua vim.lsp.diagnostic.goto_prev()<cr>
nnoremap <leader>ll <cmd>lua vim.lsp.buf.
nnoremap <leader>lh <cmd>lua vim.lsp.buf.hover()<cr>
nnoremap <leader>lf <cmd>lua vim.lsp.buf.formatting()<cr>

highlight! CmpItemAbbrMatch ctermfg=Cyan
highlight! CmpItemAbbrMatchFuzzy ctermfg=Cyan
highlight! NvimTreeFolderName ctermfg=Blue
highlight! NvimTreeOpenedFolderName ctermfg=Blue cterm=bold
highlight! NvimTreeEmptyFolderName ctermfg=Blue
