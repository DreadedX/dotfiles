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
Plug 'beyondmarc/glsl.vim'
Plug 'tpope/vim-dispatch'
Plug 'freitass/todo.txt-vim'
Plug 'tpope/vim-unimpaired'
Plug 'milkypostman/vim-togglelist'
call plug#end()

let g:neomake_airline=1

" let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
let g:ctrlp_custom_ignore = '\v[\/](bin|obj)$'

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

map <M-h> :TmuxNavigateLeft<cr>
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

set smartindent
set number
set relativenumber
set laststatus=2
set softtabstop=4
set shiftwidth=4
set noexpandtab
set completeopt-=preview

set cinkeys=0{,0},0),:,!^F,o,O,e

map <silent> <tab> :bn<cr>
map <silent> <S-tab> :bp<cr>

map <S-J> 10j
map <S-K> 10k

" map <silent> <F9> :make<cr>:cw<cr>
map <F9> :Make<cr>
map <F10> :Make debug<cr>
map <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

map <silent> <F4> :call ToggleQuickfixList()<cr>
map <silent> <F5> :e ./todo/todo.txt<cr>
map <silent> <F6> :e ./todo/done.txt<cr>
map <silent> <F7> :grep -F TODO -R ./src/**/*.cpp ./include/**/*.h<cr> :cw<cr>
map <silent> <F8> :grep -F NOTE -R ./src/**/*.cpp ./include/**/*.h<cr> :cw<cr>

function! NeatFoldText()
  let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
  let foldchar = matchstr(&fillchars, 'fold:\zs.')
  let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(foldchar, 8)
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction

set foldtext=NeatFoldText()
set foldcolumn=1
au BufRead *.cpp setlocal foldmethod=syntax
au BufRead *.cpp setlocal foldnestmax=1
