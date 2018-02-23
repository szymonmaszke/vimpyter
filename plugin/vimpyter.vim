" Check if plugin already loaded, don't use this variable elsewhere

if exists('g:loaded_vimpyter_something_random_now') || &compatible
    finish
endif

if !has('nvim')
  echo 'Currently only neovim is supported. Want to add support to vim? '
        \ . 'Contribute to the plugin'
  finish
endif

if !executable('notedown')
  echo 'notedown executable is required in order for this software to work. '
        \ . 'Check whether you have needed dependencies installed in README.md'
  finish
endif

" Set flag to prevent loading the plugin multiple times
let g:loaded_vimpyter_something_random_now = 1

if !exists('g:vimpyter_jupyter_notebook_flags')
  let g:vimpyter_jupyter_notebook_flags = ''
endif

if !exists('g:vimpyter_nteract_flags')
  let g:vimpyter_nteract_flags = ''
endif

" DEFINE COMMANDS
command! -nargs=0 VimpyterCreateView call vimpyter#createView()

command! -nargs=0 VimpyterStartJupyter call vimpyter#startJupyter()
command! -nargs=0 VimpyterStartNteract call vimpyter#startNteract()
command! -nargs=0 VimpyterUpdate call vimpyter#updateNotebook()

command! -nargs=0 VimpyterInsertPythonBlock call vimpyter#insertPythonBlock()

" DEFINE AUTOCOMMANDS
augroup VimpyterAutoCommands
    au!

    autocmd BufReadPost *.ipynb :VimpyterCreateView
    autocmd BufWritePost *.ipynb :VimpyterUpdate

augroup END

" }}}
