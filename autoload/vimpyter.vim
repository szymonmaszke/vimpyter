" Insert python block recognized by notedown
function! vimpyter#insertPythonBlock()
  exec 'normal!i```{.python .input}'
  exec 'normal!o```'
  exec 'normal!O'
endfunction

" Asynchronously starts notebook loader for original file
function! s:startNotebook(notebook_loader, flags)
  " Different async commands have to be issued for nvim/vim
  if has('nvim')
    call jobstart(a:notebook_loader . ' ' . a:flags . ' ' .
          \ b:original_file)
  else
    call job_start(a:notebook_loader . ' ' . a:flags . ' ' .
          \ b:original_file)
  endif
  echo 'Started notebook'
endfunction

function! vimpyter#startJupyter()
  call s:startNotebook('jupyter notebook', g:vimpyter_jupyter_notebook_flags)
endfunction

" CAN BE BUGGY, SEE NTERACT ISSUE: https://github.com/nteract/nteract/issues/2582
function! vimpyter#startNteract()
  call s:startNotebook('nteract', g:vimpyter_nteract_flags)
endfunction

" Update jupyter notebook when saving buffer
function! vimpyter#updateNotebook()
  " Updating notebook for neovim (another function for vim, line 53)
  function! s:updateNotebookNeovim()
    function! s:updateSuccessNeovim(job_id, data, event)
      if a:data == 0
        echo 'Updated original notebook'
      else
        echoerr 'Failed to update original notebook'
      endif
    endfunction

  "Set the last updated file flag (job_id in case of neovim)
  "(see function below: vimpyter#notebookUpdatesFinished())
  let g:vimpyter_internal_last_save_flag = jobstart(
        \ 'notedown --from markdown --to notebook ' . b:proxy_file .
        \ ' > ' . b:original_file,
        \ {
        \  'on_exit': function('s:updateSuccessNeovim')
        \ })
  endfunction

  "Updating notebook for vim
  function! s:updateNotebookVim()
    function! s:updateSuccessVim(channel, message)
      if a:message== 0
        echo 'Updated original notebook'
      else
        echoerr 'Failed to update original notebook'
      endif
    endfunction

    "Set the last updated file flag (string in case of vim, see documentation)
    "(see function below: vimpyter#notebookUpdatesFinished())
    let l:command = [&shell, &shellcmdflag,
          \ 'notedown --from markdown --to notebook ' .
          \ b:proxy_file . ' > ' . b:original_file]
    let g:vimpyter_internal_last_save_flag = job_start(
          \ l:command, {'exit_cb': function('s:updateSuccessVim')})
  endfunction

  if has('nvim')
    call s:updateNotebookNeovim()
  else
    call s:updateNotebookVim()
  endif

endfunction

function! vimpyter#createView()
  " Save original file path and create path to proxy
  let l:original_file = substitute(expand('%:p'), '\ ', '\\ ', 'g')
  " Proxy is named after original file (/ are changed to underscores _)
  let l:proxy_file = g:vimpyter_view_directory . '/' .
        \ substitute(l:original_file, '/', '-', 'g')[1:]

  " Transform json to markdown and save the result in proxy
  call system('notedown --to markdown ' . l:original_file .
        \ ' > ' . l:proxy_file)

  " Open proxy file
  silent execute 'edit' l:proxy_file

  " Save references to proxy file and the original
  let b:original_file = l:original_file
  let b:proxy_file = l:proxy_file

  " Close original file (it won't be edited directly)
  silent execute ':bd' l:original_file

  " SET FILETYPE TO ipynb
  set filetype=ipynb
endfunction

" Close vim/nvim only if all updates finished
function! vimpyter#notebookUpdatesFinished()
  if has('nvim')
    " infinite loop waiting for last update to finish
    while jobwait([g:vimpyter_internal_last_save_flag]) != [-3]
    endwhile
  else
    " Vim asynchronous API returns string instead of job_id (WHY?!)
    " It's internal flag regarding last saved file has to be empty string
    if g:vimpyter_internal_last_save_flag != ''
      " infinite loop waiting for last update to finish
      while job_status(g:vimpyter_internal_last_save_flag) !~? 'dead'
      endwhile
    endif
  endif
endfunction

" Mostly for debugging purposes, prints original's file path
function! vimpyter#getOriginalFile()
  echo 'Proxy points to: ' . b:original_file
endfunction
