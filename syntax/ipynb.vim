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
" Adding bash/other code syntax? Is it possible to detect it with low cost?
syntax region pythonCode matchgroup=Snip start="^```{.python .*" end="```" containedin=@Markdown contains=@Python

"Nice color for python's block beginning
hi link Snip SpecialComment

highlight VimpyterStartJupyter term=bold gui=bold guifg=#ffa500 ctermfg=155
highlight VimpyterStartNteract term=bold gui=bold guifg=#5b7373 ctermfg=155
highlight VimpyterUpdate term=bold gui=bold guifg=#4caf50 ctermfg=155

let b:current_syntax = 'jupyter'
