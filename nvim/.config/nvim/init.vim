call plug#begin('~/.dotfiles/nvim/.config/nvim/plugged')
	Plug 'Raimondi/delimitMate'
	Plug 'morhetz/gruvbox'
	Plug 'scrooloose/nerdtree'
	Plug 'godlygeek/tabular'
	Plug 'tomtom/tcomment_vim'
	Plug 'bling/vim-airline'
	Plug 'tommcdo/vim-exchange'
	Plug 'tpope/vim-surround'
	Plug 'christoomey/vim-tmux-navigator'
	"Plug 'MarcWeber/vim-addon-mw-utils'
	"Plug 'tomtom/tlib_vim'
	"Plug 'SirVer/ultisnips'
	"Plug 'honza/vim-snippets'
	Plug 'tpope/vim-dispatch'
	"Plug 'tpope/vim-unimpaired'
	Plug 'milkypostman/vim-togglelist'
	Plug 'moll/vim-bbye'
	"Plug 'tpope/vim-fugative'
	Plug 'junegunn/fzf', {'do': './install --bin'}
	"Plug 'Valloric/YouCompleteMe', {'do': './install.py --clang-completer --go-completer --rust-completer --js-completer --java-completer'}
	Plug 'Valloric/YouCompleteMe', {'do': './install.py --clang-completer'}

	Plug 'digitaltoad/vim-pug'
	Plug 'tikhomirov/vim-glsl'
	Plug 'rust-lang/rust.vim'
call plug#end()

" Setup custom syntax
au BufRead,BufNewFile *.lang setfiletype lang

" Load vim config in current directory
silent! so .vimlocal

" Theme
colorscheme gruvbox
set t_Co=256
set t_ZH=[3m
set t_ZR=[23m
set background=dark

set list lcs=tab:\|\ 

" Powerline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='gruvbox'

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
set mouse=a

" DelimitMate
let delimitMate_expand_cr = 1

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

" Fold in functions
fu! CustomFoldText()
    "get first non-blank line
    let fs = v:foldstart
    while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
    endwhile
    if fs > v:foldend
        let line = getline(v:foldstart)
    else
        let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
    endif

    let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
    let foldSize = 1 + v:foldend - v:foldstart
    let foldSizeStr = " " . foldSize . " lines "
    let foldLevelStr = repeat("+--", v:foldlevel)
    let lineCount = line("$")
    let foldPercentage = printf("[%.1f", (foldSize*1.0)/lineCount*100) . "%] "
    let expansionString = repeat(".", w - strwidth(foldSizeStr.line.foldLevelStr.foldPercentage))
    return line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
endf

set foldtext=CustomFoldText()
set foldcolumn=1
au BufRead *.cpp,*.go,*.js setlocal foldmethod=syntax
au BufRead *.cpp,*.go,*.js setlocal foldnestmax=1

" Use fzf and silver searcher to search files (REQUIRES: the_silver_searcher)
map <silent> <C-p> :call fzf#run(fzf#wrap('custom', {'source': 'ag -g ""'}, 0))<cr>
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

" YouCompleteMe
set completeopt=menuone,menu
let g:ycm_confirm_extra_conf = 0
let g:ycm_error_symbol = ''
let g:ycm_warning_symbol = ''

" Ultisnip
let g:UltiSnipsExpandTrigger='<C-s>'
