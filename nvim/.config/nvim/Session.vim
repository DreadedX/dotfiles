let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/.dotfiles/nvim/.config/nvim
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +379 init.lua
badd +18 lua/plugins/trouble.lua
badd +5 lua/plugins/undotree.lua
badd +1 lua/themes/gruvbox.lua
badd +3 lua/plugins/todo-comments.lua
badd +9 lua/options.lua
badd +17 lua/keymaps.lua
badd +15 lua/autocmds.lua
badd +1 lua/plugins/autopairs.lua
badd +1 lua/plugins/autotag.lua
badd +4 lua/plugins/bufdel.lua
badd +1 lua/plugins/bufferline.lua
badd +1 lua/plugins/colorizer.lua
badd +1 lua/plugins/comment.lua
badd +9 lua/plugins/diffview.lua
badd +1 lua/plugins/guess-indent.lua
badd +1 lua/plugins/neotree.lua
badd +7 lua/plugins/surround.lua
badd +1 lua/plugins/tmux-navigation.lua
badd +1 lua/plugins/whitespace.lua
badd +22 lua/kickstart/plugins/autoformat.lua
badd +39 ~/Projects/rust/automation_rs/src/main.rs
badd +13 lua/plugins/treesj.lua
badd +10 ~/.dotfiles/nvim/.config/nvim/lua/plugins/symbols-outline.lua
badd +3 lua/plugins/null-ls.lua
argglobal
%argdel
edit init.lua
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 142 + 142) / 284)
exe 'vert 2resize ' . ((&columns * 141 + 142) / 284)
argglobal
balt lua/options.lua
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 379 - ((53 * winheight(0) + 35) / 70)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 379
normal! 045|
wincmd w
argglobal
if bufexists(fnamemodify("lua/plugins/null-ls.lua", ":p")) | buffer lua/plugins/null-ls.lua | else | edit lua/plugins/null-ls.lua | endif
if &buftype ==# 'terminal'
  silent file lua/plugins/null-ls.lua
endif
balt lua/keymaps.lua
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 3 - ((2 * winheight(0) + 35) / 70)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 3
normal! 024|
wincmd w
exe 'vert 1resize ' . ((&columns * 142 + 142) / 284)
exe 'vert 2resize ' . ((&columns * 141 + 142) / 284)
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
