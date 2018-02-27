" Insert python block recognized by notedown
function! vimpyter#insertPythonBlock()
  exec 'normal!i```{.python .input}'
  exec 'normal!o```'
  exec 'normal!O'
endfunction

" Asynchronously starts notebook loader for original file
function! s:startNotebook(notebook_loader, flags)
  if exists('b:original_file')
    call jobstart(a:notebook_loader . ' ' . a:flags . ' ' . b:original_file)
    echo 'Started ' . a:notebook_loader
  else
    echo 'No reference to original .ipynb file'
  endif
endfunction

function! vimpyter#startJupyter()
  call s:startNotebook('jupyter notebook', g:vimpyter_jupyter_notebook_flags)
endfunction

" CAN BE BUGGY, SEE NTERACT ISSUE: https://github.com/nteract/nteract/issues/2582
function! vimpyter#startNteract()
  call s:startNotebook('nteract', g:vimpyter_nteract_flags)
endfunction

function! vimpyter#updateNotebook()
  if exists('b:original_file')
    let g:vimpyter_internal_last_save_flag = jobstart('notedown --from markdown --to notebook ' . b:proxy_file .
          \ ' > ' . b:original_file)
  else
    echo 'Unable to update original file, buffer not found'
  endif
endfunction

function! vimpyter#createView()
  " Save original file path and create path to proxy
  let l:original_file = expand('%:p')
  " Proxy is named after original file (/ are changed to underscores _)
  let l:proxy_file = g:vimpyter_view_directory . '/' . substitute(l:original_file, '/', '_', 'g')[1:]

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

function! vimpyter#notebookUpdatesFinished()
  while jobwait([g:vimpyter_internal_last_save_flag], 5000) != -3
  endwhile
endfunction

function! vimpyter#getOriginalFile()
  echo 'This view points to: ' . b:original_file
endfunction
