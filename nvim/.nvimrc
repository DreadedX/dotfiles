call plug#begin('~/.dotfiles/nvim/.nvim/plugged')
Plug 'kien/ctrlp.vim'
Plug 'FelikZ/ctrlp-py-matcher'
Plug 'Raimondi/delimitMate'
Plug 'morhetz/gruvbox'
Plug 'Yggdroot/indentLine'
Plug 'scrooloose/nerdtree'
Plug 'godlygeek/tabular'
Plug 'majutsushi/tagbar'
Plug 'tomtom/tcomment_vim'
Plug 'bling/vim-airline'
Plug 'tommcdo/vim-exchange'
Plug 'justinmk/vim-matchparenalways'
Plug 'tpope/vim-surround'
Plug 'christoomey/vim-tmux-navigator'
Plug 'Valloric/YouCompleteMe'
call plug#end()

let g:neomake_airline=1

let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
let g:ctrlp_custom_ignore = '\v[\/](build|bin)$'

let delimitMate_expand_cr = 1

colorscheme gruvbox
set t_Co=256
set t_ZH=[3m
set t_ZR=[23m
set background=dark

let g:indentLine_char = '│'

map <silent> <M-a> :NERDTreeToggle<cr>

map <silent> <M-2> :TagbarToggle<cr>

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='gruvbox'

map <M-l> :TmuxNavigateLeft<cr>
map <M-j> :TmuxNavigateDown<cr>
map <M-k> :TmuxNavigateUp<cr>
map <M-l> :TmuxNavigateRight<cr>

syntax on
filetype plugin indent on

set smartindent
set number
set relativenumber
set laststatus=2
set softtabstop=4
set shiftwidth=4
set noexpandtab

map <silent> <tab> :bn<cr>
map <silent> <S-tab> :bp<cr>

map <S-J> <pagedown>
map <S-K> <pageup>

map <F9> :Topen gradle build<cr>
