" Sanity check
if exists('b:current_syntax')
    finish
endif

" Setup markdown syntax file
runtime! syntax/markdown.vim

" Load markdown syntax into variable
syntax include @Markdown syntax/markdown.vim

" Clear current syntax and include python syntax file
let b:current_syntax = ''
unlet b:current_syntax
syntax include @Python syntax/python.vim
" Set up higlighting:
" Python blocks use python, everything else in contained in Markdown syntax
syntax region pythonCode matchgroup=Snip start="^```{.python .*" end="```" containedin=@Markdown contains=@Python

"Nice color for python's block beginning
hi link Snip SpecialComment
let b:current_syntax = 'jupyter'
