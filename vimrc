execute pathogen#infect()
syntax on
filetype plugin indent on
let g:EclimCompletionMethod = 'omnifunc'

set t_Co=256
set background=dark
colorscheme solarized

nnoremap <silent> <M-l> :TmuxNavigateLeft<cr>
nnoremap <silent> <M-j> :TmuxNavigateDown<cr>
nnoremap <silent> <M-k> :TmuxNavigateUp<cr>
nnoremap <silent> <M-l> :TmuxNavigateRight<cr>

map <F2> :NERDTreeToggle<cr>
nmap <F8> :TagbarToggle<CR>
map <F3> \be

setlocal completeopt-=preview
set laststatus=2
let g:Powerline_symbols = 'fancy'
set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/
let b:EclimPhpHtmlValidate = 1
