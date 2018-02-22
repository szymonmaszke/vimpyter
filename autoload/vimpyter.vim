" Inserts python block recognized by notedown
function! vimpyter#insertPythonBlock()
  exec 'normal!i```python'
  exec 'normal!o```'
  exec 'normal!O'
endfunction

" Asynchronously starts notebook loader for given file
function! s:startNotebook(notebook_loader)
  if exists('b:original_file')
    call jobstart(a:notebook_loader . ' ' . b:original_file)
    echo 'Started ' . a:notebook_loader
  else
    echo 'No reference to original .ipynb file'
  endif
endfunction

function! vimpyter#startJupyter()
  call s:startNotebook('jupyter notebook')
endfunction

function! vimpyter#startNteract()
  call s:startNotebook('nteract')
endfunction

" Asynchronously (if possible) update jupyter notebook
function! vimpyter#updateNotebook()
  if exists('b:original_file')
    call jobstart('notedown --from markdown --to notebook ' . b:proxy_file .
          \ ' > ' . b:original_file)
    echo 'Updated original notebook'
  else
    echo 'Unable to update original file, buffer not found'
  endif
endfunction

" CREATE VIEWS DIRECTORY
function! vimpyter#createView()
  let l:proxy_file = tempname()
  let l:original_file = expand('%:p')

  call system('notedown --to markdown ' . l:original_file .
        \ ' > ' . l:proxy_file)

  execute 'edit' l:proxy_file

  let b:original_file = l:original_file
  let b:proxy_file = l:proxy_file

  execute ':bd' l:original_file

endfunction
