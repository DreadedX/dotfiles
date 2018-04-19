" quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif
" @todo \ at end of line should continue on next line

" Hello this is a test to see if it auto wraps the text when the text has been
" going on for way too long

" syn match   langSpecial display contained "\\\(x\x\+\|\o\{1,3}\|.\|$\)"
" We only highlight valid escape characters as for now it just ignores unknown
" thing
syn match   langSpecial display contained "\\[abfnrtv]"
syn match   langError   "^.\+"
syn keyword langTodo    contained TODO FIXME XXX NOTE
syn match   langTodo    contained "@todo"
syn match   langTodo    contained "@note"
syn region  langSection start="^\s*\[" end="\]"
syn match   langKey     "^.\{-}\ze="
syn match   langValue   "[#=]\zs.*$" contains=langSub,langSpecial,langValue
syn match   langValue   contained "\\\n.\+" contains=langValue
" syn match   langSub     "{[^}]\+}" " This is for fmt support
syn match   langSub     "{\d\+}"
syn match   langComment "[#;].*$" contains=langTodo

hi def link langTodo    Todo
hi def link langSpecial Special
hi def link langSection Type
hi def link langKey     Identifier
hi def link langValue   String
hi def link langValue2   String
hi def link langSub     Constant
hi def link langComment Comment
hi def link langError   Error


let b:current_syntax = "lang"

" vim: sts=2 sw=2 et
