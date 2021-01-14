call plug#begin('~/.dotfiles/nvim/.config/nvim/plugged')
	Plug 'morhetz/gruvbox'
	Plug 'bling/vim-airline'

	Plug 'Raimondi/delimitMate'
	Plug 'scrooloose/nerdtree'
	Plug 'tomtom/tcomment_vim'
	Plug 'tpope/vim-surround'
	Plug 'christoomey/vim-tmux-navigator'
	Plug 'tpope/vim-dispatch'
	Plug 'milkypostman/vim-togglelist'
	Plug 'moll/vim-bbye'
	Plug 'junegunn/fzf', {'do': './install --bin'}
	Plug 'junegunn/fzf.vim'
	Plug 'tpope/vim-fugitive'
	Plug 'ConradIrwin/vim-bracketed-paste'

	Plug 'ncm2/ncm2'
	Plug 'roxma/nvim-yarp'
	Plug 'ncm2/ncm2-bufword'
	Plug 'ncm2/ncm2-path'
	Plug 'ncm2/ncm2-tmux'
	Plug 'ncm2/ncm2-tern',  {'do': 'npm install'}

	Plug 'Shougo/echodoc.vim'
	
	Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
call plug#end()

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
map <silent> <F2> :NERDTreeToggle<cr>
map <silent> <M-h> :TmuxNavigateLeft<cr>
map <silent> <M-j> :TmuxNavigateDown<cr>
map <silent> <M-k> :TmuxNavigateUp<cr>
map <silent> <M-l> :TmuxNavigateRight<cr>
map <silent> <tab> :bn<cr>
map <silent> <S-tab> :bp<cr>
map <silent> <S-j> 10j
map <silent> <S-k> 10k
map <silent> <C-b> :Bdelete<cr>
map <silent> <F4> :call ToggleQuickfixList()<cr>
map <silent> <F11> :noh<cr>

map <silent> <leader>m :call LanguageClient_contextMenu()<cr>
map <silent> <leader>n :cnext<cr>
map <silent> <leader>N :cprevious<cr>
map <silent> <leader>b :Buffers<cr>
map <silent> <leader>c :Commits<cr>
map <silent> <leader>f :Ag<cr>

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
imap <expr> <BS> pumvisible() ? "\<bs>" : "<Plug>delimitMateBS"
imap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "<Plug>delimitMateCR"

" Use fzf and silver searcher to search files (REQUIRES: the_silver_searcher)
if executable('ag')
	map <silent> <C-p> :call fzf#run(fzf#wrap('custom', {'source': 'ag -g ""'}, 0))<cr>
endif
let g:fzf_layout = {'down': '~20%'}
let g:fzf_colors =
\ { 'fg':	['fg', 'Normal'],
  \ 'bg':	['bg', 'Normal'],
  \ 'hl':	['fg', 'Comment'],
  \ 'fg+':	['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':	['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':	['fg', 'Statement'],
  \ 'info':	['fg', 'PreProc'],
  \ 'border':	['fg', 'Ignore'],
  \ 'prompt':	['fg', 'Conditional'],
  \ 'pointer':	['fg', 'Exception'],
  \ 'marker':	['fg', 'Keyword'],
  \ 'spinner':	['fg', 'Label'],
  \ 'header':	['fg', 'Comment'] }

autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noruler
  \| autocmd BufLeave <buffer> set laststatus=2 ruler

" ncm2
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect

" Echodoc
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'signature'

" LanguageClient
let g:LanguageClient_serverCommands = {
\ 'cpp': ['clangd'],
\ 'cc': ['clangd'],
\ 'c': ['clangd'],
\ 'python': ['pyls'],
\ }
let g:LanguageClient_diagnosticsDisplay = {
\ 1: {
\    "name": "Error",
\    "texthl": "GruvBoxRedSign",
\    "signText": "",
\    "signTexthl": "GruvBoxRedSign",
\    "virtualTexthl": "GruvBoxRedSign",
\ },
\ 2: {
\    "name": "Warning",
\    "texthl": "ALEWarning",
\    "signText": "",
\    "signTexthl": "ALEWarningSign",
\    "virtualTexthl": "GruvBoxYellowSign",
\  },
\  3: {
\    "name": "Information",
\    "texthl": "ALEInfo",
\    "signText": "",
\    "signTexthl": "ALEInfoSign",
\    "virtualTexthl": "Todo",
\  },
\  4: {
\    "name": "Hint",
\    "texthl": "ALEInfo",
\    "signText": "",
\    "signTexthl": "ALEInfoSign",
\    "virtualTexthl": "Todo",
\  },}
