execute pathogen#infect()
syntax on
filetype plugin indent on
let g:SuperTabDefaultCompletionType = 'context'

set t_Co=256
set background=dark
colorscheme solarized

nnoremap <silent> <M-l> :TmuxNavigateLeft<cr>
nnoremap <silent> <M-j> :TmuxNavigateDown<cr>
nnoremap <silent> <M-k> :TmuxNavigateUp<cr>
nnoremap <silent> <M-l> :TmuxNavigateRight<cr>

map <F2> :NERDTreeToggle<cr>
map <F3> \be
