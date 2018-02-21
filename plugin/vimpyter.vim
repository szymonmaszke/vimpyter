" Check if plugin already loaded, don't use this variable elsewhere

if exists('g:loaded_vimpyter_something_random_now')
    finish
endif

if !has('nvim')
  echo 'Currently only neovim is supported. Want to add support to vim? '
        \ . 'Contribute to the plugin'
  finish
endif

" Set flag to prevent loading the plugin multiple times
let g:loaded_vimpyter_something_random_now = 1

" DEFINE COMMANDS
command! -nargs=0 VimpyterJupyterMarkdown call vimpyter#jupyterToMarkdown()
command! -nargs=0 VimpyterMarkdownJupyter call vimpyter#markdownToJupyter()

command! -nargs=0 VimpyterStartNotebook call vimpyter#startNotebook()
command! -nargs=0 VimpyterUpdate call vimpyter#updateNotebook()

command! -nargs=0 VimpyterInsertPythonBlock call vimpyter#insertPythonBlock()

" DEFINE AUTOCOMMANDS
augroup VimpyterAutoCommands
    au!

    autocmd BufReadPre *.ipynb silent :VimpyterJupyterMarkdown
    autocmd BufWritePost *.ipynb silent :VimpyterUpdate

augroup END

" }}}
