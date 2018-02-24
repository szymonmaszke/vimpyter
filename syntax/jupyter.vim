if exists('b:current_syntax')
    finish
endif

runtime! syntax/markdown.vim

syntax include @Markdown syntax/markdown.vim

let b:current_syntax = ''
unlet b:current_syntax
syntax include @Python syntax/python.vim
syntax region pythonCode matchgroup=Snip start="^```{.python .*" end="```" containedin=@Markdown contains=@Python

"Nice color for block beginning
hi link Snip SpecialComment
let b:current_syntax = 'jupyter'
