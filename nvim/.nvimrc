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
Plug 'vim-scripts/OmniCppComplete'
Plug 'ervandew/supertab'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'
" Plug 'Valloric/YouCompleteMe'
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
" set background=light

let g:indentLine_char = '│'

" map <silent> <M-a> :NERDTreeToggle<cr>
map <silent> <F2> :NERDTreeToggle<cr>

" map <silent> <M-2> :TagbarToggle<cr>
map <silent> <F3> :TagbarToggle<cr>

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='gruvbox'

map <M-l> :TmuxNavigateLeft<cr>
map <M-j> :TmuxNavigateDown<cr>
map <M-k> :TmuxNavigateUp<cr>
map <M-l> :TmuxNavigateRight<cr>

set omnifunc=syntaxcomplete#Complete " override built-in C omnicomplete with C++ OmniCppComplete plugin
let OmniCpp_GlobalScopeSearch   = 1
let OmniCpp_DisplayMode         = 1
let OmniCpp_ShowScopeInAbbr     = 0 "do not show namespace in pop-up
let OmniCpp_ShowPrototypeInAbbr = 1 "show prototype in pop-up
let OmniCpp_ShowAccess          = 1 "show access in pop-up
let OmniCpp_SelectFirstItem     = 1 "select first item in pop-up
set completeopt=menuone,menu,longest

let g:SuperTabDefaultCompletionType = "<C-X><C-O>"

" let g:SuperTabDefaultCompletionType = "<c-n>"

syntax on
filetype plugin indent on

set nocp
set smartindent
set number
set relativenumber
set laststatus=2
set softtabstop=4
set shiftwidth=4
set noexpandtab
set completeopt-=preview

map <silent> <tab> :bn<cr>
map <silent> <S-tab> :bp<cr>

map <S-J> <pagedown>
map <S-K> <pageup>

map <silent> <F9> :make<cr>:cw<cr>
map <F10> :!./platformer<cr>
map <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
