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
set list lcs=tab:┃\ ,trail:·

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='gruvbox'
let g:airline_section_z = '%3p%% %#__accent_bold#%4l%#__restore__#%#__accent_bold#/%L%#__restore__# :%3v'
let g:airline_section_warning = ''

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

let g:airline_symbols.dirty = " ±"
let g:airline_symbols.notexists = " "

" NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

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

" Keybindings
map <silent> <M-2> :NERDTreeToggle<cr>
map <silent> <M-h> :TmuxNavigateLeft<cr>
map <silent> <M-j> :TmuxNavigateDown<cr>
map <silent> <M-k> :TmuxNavigateUp<cr>
map <silent> <M-l> :TmuxNavigateRight<cr>
map <silent> <tab> :bn<cr>
map <silent> <S-tab> :bp<cr>
map <silent> <S-j> 10j
map <silent> <S-k> 10k
map <silent> <C-b> :Bdelete<cr>
map <silent> <M-3> :call ToggleQuickfixList()<cr>
map <silent> <M-1> :noh<cr>

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
imap <expr> <BS> pumvisible() ? "\<bs>" : "<Plug>delimitMateBS"
imap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "<Plug>delimitMateCR"

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
map <silent> <leader>ln :lua vim.lsp.diagnostic.goto_next()<cr>
map <silent> <leader>lp :lua vim.lsp.diagnostic.goto_prev()<cr>
map <leader>ll :lua vim.lsp.buf.
map <silent> <leader>lh :lua vim.lsp.buf.hover()<cr>

let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.erb,*.jsx,*.tsx"
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.tsx,*.erb'
