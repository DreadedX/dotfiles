execute pathogen#infect()
syntax on
filetype plugin indent on
let g:EclimCompletionMethod = 'omnifunc'

set t_Co=256
set background=dark
colorscheme solarized
set number

nnoremap <silent> <M-l> :TmuxNavigateLeft<cr>
nnoremap <silent> <M-j> :TmuxNavigateDown<cr>
nnoremap <silent> <M-k> :TmuxNavigateUp<cr>
nnoremap <silent> <M-l> :TmuxNavigateRight<cr>

map <F2> :NERDTreeToggle<cr>
nmap <F4> :TagbarToggle<CR>
map <F3> \be
map <F5> \k

setlocal completeopt-=preview
set laststatus=2
let g:Powerline_symbols = 'fancy'
set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/
let b:EclimPhpHtmlValidate = 1
