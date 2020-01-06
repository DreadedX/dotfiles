call plug#begin('~/.dotfiles/nvim/.config/nvim/plugged')
	Plug 'morhetz/gruvbox'
	Plug 'bling/vim-airline'

	Plug 'Raimondi/delimitMate'
	" For some reason this overrides existing keybindings
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
	" @todo Is this really useful
	Plug 'ConradIrwin/vim-bracketed-paste'

	Plug 'prabirshrestha/async.vim'
	Plug 'prabirshrestha/vim-lsp'
	Plug 'prabirshrestha/asyncomplete.vim'
	Plug 'prabirshrestha/asyncomplete-lsp.vim'
	Plug 'prabirshrestha/asyncomplete-buffer.vim'
	Plug 'prabirshrestha/asyncomplete-file.vim'
	Plug 'wellle/tmux-complete.vim'

	" @todo Figure out how to integrate this with flint
	" Plug 'Shougo/vimproc.vim', {'do' : 'make'}
	" Plug 'idanarye/vim-vebugger'

	Plug 'digitaltoad/vim-pug'
	Plug 'tikhomirov/vim-glsl'
	Plug 'rust-lang/rust.vim'
	Plug 'OrangeT/vim-csharp'
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

let g:airline_symbols.dirty = " ⚡"
let g:airline_symbols.notexists = " ╳"

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
set updatetime=750

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
map <silent> <F9> :Make<cr>
map <silent> <F11> :noh<cr>

map <silent> <leader>e :LspNextDiagnostic<cr>
map <silent> <leader>E :LspPreviousDiagnostic<cr>
map <silent> <c-]> :LspPeekDefinition<cr>
map <silent> <leader>E :LspPreviousError<cr>
map <silent> <leader>n :cnext<cr>
map <silent> <leader>N :cprevious<cr>
map <silent> <leader>b :Buffers<cr>
map <silent> <leader>c :Commits<cr>
map <silent> <leader>f :Ag<cr>

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <C-y> pumvisible() ? asyncomplete#close_popup() : "\<C-y>"
imap <expr> <BS> pumvisible() ? "\<C-e>\<bs>" : "<Plug>delimitMateBS"
imap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "<Plug>delimitMateCR"
imap <c-space> <Plug>(asyncomplete_force_refresh)

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
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

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
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_signs_enabled = 1
let g:lsp_signs_error = {'text': ''}
let g:lsp_signs_warning = {'text': ''}
let g:lsp_highlights_enabled = 0
let g:lsp_virtual_text_enabled = 1

set foldmethod=expr
  \ foldexpr=lsp#ui#vim#folding#foldexpr()
  \ foldtext=lsp#ui#vim#folding#foldtext()

" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/vim-lsp.log')

highlight lspReference ctermfg=red guifg=red ctermbg=green guibg=green

highlight link LspErrorText GruvBoxRedSign
highlight link LspWarningText GruvBoxYellowSign

" asyncomplete

call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'whitelist': ['*'],
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ }))

" @todo This currentyly does not work
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
