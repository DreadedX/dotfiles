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
set t_ZH=[3m
set t_ZR=[23m

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='gruvbox'
let g:indentLine_char = '│'
let delimitMate_expand_cr = 1
let g:EclimCompletionMethod = 'omnifunc'
" let b:EclimPhpHtmlValidate = 1

nnoremap <silent> <M-l> :TmuxNavigateLeft<cr>
nnoremap <silent> <M-j> :TmuxNavigateDown<cr>
nnoremap <silent> <M-k> :TmuxNavigateUp<cr>
nnoremap <silent> <M-l> :TmuxNavigateRight<cr>
nnoremap <silent> <F12> :noh<cr>
nnoremap <F4> :buffers<cr>:buffer<space>
map <F2> :NERDTreeToggle<cr>
map <F3> :TagbarToggle<cr>
" map <F5> :!./%<cr>

if !empty(glob("./build.gradle"))
  map <F5> :!clear && gradle build<cr>
  map <F6> :!clear && gradle run<cr>
endif
