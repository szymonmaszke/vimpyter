" Inserts python block recognized by notedown
function! vimpyter#insertPythonBlock()
  exec 'normal!i```python'
  exec 'normal!o```'
  exec 'normal!O'
endfunction

" Asynchronously (if possible) starts jupyter notebook for given file
function! vimpyter#startNotebook()
  if filereadable('.' . expand('%:r') . '_tmp.ipynb')
    call jobstart('jupyter notebook .' . expand('%:r') . '_tmp.ipynb')
    echo 'Started Jupyter notebook'
  else
    echo 'Temporary Jupyter notebook not found'
  endif
endfunction

" Asynchronously (if possible) update jupyter notebook
function! vimpyter#updateNotebook()
  call jobstart('notedown ' . expand('%') . ' --from markdown -o .' .
        \ expand('%:r') . '_tmp.ipynb')
endfunction

function! vimpyter#jupyterToMarkdown()
  function! s:markdownHandle(job_id, data, event)
    if a:data == 0
      normal! ggdG
      silent execute 'r .%:r_tmp.md'
      silent execute '!rm .%:r_tmp.md'
      " TURN OFF ALE BEFORE WRITE
      silent write
    else
      silent execute '!rm .%:r_tmp.md'
      echo 'Unable to transform jupyter into markdown'
    endif
  endfunction

  let s:callbacks = {
        \ 'on_exit': function('s:markdownHandle'),
        \}

  call jobstart('cp % .%:r_tmp.ipynb')
  call jobstart('notedown --strip --to markdown ' . expand('%') . ' > .' .
        \ expand('%:r') . '_tmp.md', s:callbacks)

endfunction

" ONLY POSSIBLE THROUGH BINDING
function! vimpyter#markdownToJupyter()
  if filereadable('.' . expand('%:r') . '_tmp.ipynb')
    normal! ggdG
    silent execute 'r .%:r_tmp.ipynb'
    silent write
    silent execute '!rm .%:r_tmp.ipynb'
  else
    echo 'Temporary Jupyter notebook not found'
  endif
endfunction
