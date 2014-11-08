execute pathogen#infect()
syntax on
filetype plugin indent on
colorscheme gruvbox

set t_Co=256
set background=dark
set number
set incsearch 
set hlsearch
set completeopt-=preview
set laststatus=2
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='gruvbox'
let g:EclimCompletionMethod = 'omnifunc'
let b:EclimPhpHtmlValidate = 1

nnoremap <silent> <M-l> :TmuxNavigateLeft<cr>
nnoremap <silent> <M-j> :TmuxNavigateDown<cr>
nnoremap <silent> <M-k> :TmuxNavigateUp<cr>
nnoremap <silent> <M-l> :TmuxNavigateRight<cr>
nnoremap <silent> <F12> :noh<cr>
map <F2> :NERDTreeToggle<cr>
map <F3> :TagbarToggle<cr>
map <F12> :Tab<cr>
map <F9> :!./%<cr>
