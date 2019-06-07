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

	Plug 'prabirshrestha/async.vim'
	Plug 'prabirshrestha/vim-lsp'
	Plug 'prabirshrestha/asyncomplete.vim'
	Plug 'prabirshrestha/asyncomplete-lsp.vim'
	Plug 'prabirshrestha/asyncomplete-buffer.vim'
	Plug 'prabirshrestha/asyncomplete-file.vim'
	Plug 'wellle/tmux-complete.vim'
	" Plug 'OmniSharp/omnisharp-vim'

	Plug 'digitaltoad/vim-pug'
	Plug 'tikhomirov/vim-glsl'
	Plug 'rust-lang/rust.vim'
	Plug 'OrangeT/vim-csharp'
call plug#end()

" Load vim config in current directory
silent! so .vimlocal

" DelimitMate
let delimitMate_expand_cr = 1

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
let g:airline_section_z = '%3p%% %#__accent_bold#%4l%#__restore__#%#__accent_bold#/%L%#__restore__# :%3v'
let g:airline_section_warning = ''

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

" Setup custom syntax
au BufRead,BufNewFile *.lang setfiletype lang
au BufRead,BufNewFile *.razor setfiletype cshtml

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

map <leader>N :LspNextError<cr>
map <leader>P :LspPreviousError<cr>
map <leader>n :cnext<cr>
map <leader>p :cprevious<cr>

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"
imap <c-space> <Plug>(asyncomplete_force_refresh)

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
au BufRead *.cpp,*.h,*.go,*.js setlocal foldmethod=syntax
au BufRead *.cpp,*.h,*.go,*.js setlocal foldnestmax=2

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

" vim-lsp
if executable('clangd')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd', '-background-index']},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })
endif

if executable('pyls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif

au User lsp_setup call lsp#register_server({
	\ 'name': 'omnisharp',
	\ 'cmd': {server_info->['mono', '/home/tim/Downloads/omnisharp-mono/OmniSharp.exe', '-lsp']},
	\ 'whitelist': ['cs'],
	\ })

let g:lsp_text_edit_enabled = 0
let g:lsp_signs_enabled = 1
let g:lsp_signs_error = {'text': ''}
let g:lsp_signs_warning = {'text': ''}
let g:lsp_highlights_enabled = 0
let g:lsp_virtual_text_enabled = 1

let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/vim-lsp.log')

highlight lspReference ctermfg=red guifg=red ctermbg=green guibg=green

highlight link LspErrorText GruvBoxRedSign
highlight link LspWarningText GruvBoxYellowSign

" asyncomplete
call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'whitelist': ['*'],
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ }))

au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ 'name': 'file',
    \ 'whitelist': ['*'],
    \ 'completor': function('asyncomplete#sources#file#completor')
    \ }))

let g:tmuxcomplete#asyncomplete_source_options = {
            \ 'name':      'tmux',
            \ 'whitelist': ['*'],
            \ 'config': {
            \     'splitmode':      'words',
            \     'filter_prefix':   1,
            \     'show_incomplete': 1,
            \     'sort_candidates': 0,
            \     'scrollback':      0,
            \     'truncate':        0
            \     }
            \ }
