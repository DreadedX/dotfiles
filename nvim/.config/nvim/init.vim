call plug#begin('~/.dotfiles/nvim/.config/nvim/plugged')
Plug 'kien/ctrlp.vim'
Plug 'FelikZ/ctrlp-py-matcher'
Plug 'Raimondi/delimitMate'
Plug 'morhetz/gruvbox'
Plug 'Yggdroot/indentLine'
Plug 'scrooloose/nerdtree'
Plug 'godlygeek/tabular'
" Plug 'majutsushi/tagbar'
Plug 'tomtom/tcomment_vim'
Plug 'bling/vim-airline'
Plug 'tommcdo/vim-exchange'
Plug 'justinmk/vim-matchparenalways'
Plug 'tpope/vim-surround'
Plug 'christoomey/vim-tmux-navigator'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Plug 'beyondmarc/glsl.vim'
Plug 'tpope/vim-dispatch'
" Plug 'freitass/todo.txt-vim'
Plug 'tpope/vim-unimpaired'
Plug 'milkypostman/vim-togglelist'
Plug 'Valloric/YouCompleteMe'
" Plug 'Shougo/deoplete.nvim'
" Plug 'vim-scripts/LanguageTool'
" Plug 'pangloss/vim-javascript'
Plug 'moll/vim-bbye'
Plug 'tpope/vim-fugitive'
Plug 'tikhomirov/vim-glsl'
call plug#end()

let g:ctrlp_custom_ignore = '\v[\/](bin|docs)$'

let delimitMate_expand_cr = 1

colorscheme gruvbox
set t_Co=256
set t_ZH=[3m
set t_ZR=[23m
set background=dark

" let g:indentLine_char = '│'
" let g:indentLine_color_term = 239
set list lcs=tab:\│\ 

" map <silent> <M-a> :NERDTreeToggle<cr>
map <silent> <F2> :NERDTreeToggle<cr>

" map <silent> <M-2> :TagbarToggle<cr>
" map <silent> <F3> :TagbarToggle<cr>

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='gruvbox'

map <M-h> :TmuxNavigateLeft<cr>
map <M-j> :TmuxNavigateDown<cr>
map <M-k> :TmuxNavigateUp<cr>
map <M-l> :TmuxNavigateRight<cr>

" set omnifunc=syntaxcomplete#Complete " override built-in C omnicomplete with C++ OmniCppComplete plugin
" let OmniCpp_GlobalScopeSearch   = 1
" let OmniCpp_DisplayMode         = 1
" let OmniCpp_ShowScopeInAbbr     = 0 "do not show namespace in pop-up
" let OmniCpp_ShowPrototypeInAbbr = 1 "show prototype in pop-up
" let OmniCpp_ShowAccess          = 1 "show access in pop-up
" let OmniCpp_SelectFirstItem     = 1 "select first item in pop-up

set completeopt=menuone,menu,preview
let g:ycm_confirm_extra_conf = 0
let g:ycm_error_symbol = ''
let g:ycm_warning_symbol = ''

let g:UltiSnipsExpandTrigger="<c-s>"

syntax on
filetype plugin indent on

set smartindent
set number
set relativenumber
set laststatus=2
set softtabstop=4
set tabstop=4
set shiftwidth=4
set noexpandtab
set completeopt-=preview

" I do not remember what this is for
" set cinkeys=0{,0},0),:,!^F,o,O,e

let g:languagetool_jar='$HOME/.local/bin/LanguageTool-3.2/languagetool-commandline.jar'
let g:languagetool_lang="nl"

map <silent> <tab> :bn<cr>
map <silent> <S-tab> :bp<cr>

map <S-J> 10j
map <S-K> 10k

autocmd FileType cpp map <F9> :Make<cr>
autocmd FileType cpp map <F10> :Make debug<cr>
autocmd FileType cpp map <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

autocmd FileType go let &makeprg="go run %:p:h/*.go"
autocmd FileType go map <F10> :Make<cr>

autocmd FileType tex map <F9> :!arara %<cr>

if !filereadable(expand("%:p:h")."/Makefile")
    let &makeprg="cd CMake/default && make"
endif
map <silent> <F4> :call ToggleQuickfixList()<cr>
map <silent> <F5> :e ./todo/todo.txt<cr>
map <silent> <F6> :e ./todo/done.txt<cr>
" map <silent> <F7> :grep -F TODO -R ./src/**/*.cpp ./include/**/*.h<cr> :cw<cr>
" map <silent> <F8> :grep -F NOTE -R ./src/**/*.cpp ./include/**/*.h<cr> :cw<cr>

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

function! MyFoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}

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

" set foldtext=NeatFoldText()
set foldtext=CustomFoldText()
set foldcolumn=1
au BufRead *.cpp,*.go,*.js setlocal foldmethod=syntax
au BufRead *.cpp,*go,*.js setlocal foldnestmax=1
