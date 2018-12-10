" Substitution of fold name, effectively doing the following
" {.python .input n=i} -> In[i]:
" {.json .output n=i} -> Out[i]:
" {.python .input} -> In[]:

function! CellFoldingNaming()
  let l:fold_text = getline(v:foldstart)
  if l:fold_text =~# '```{.python .input  n='
    let l:code_cell = 'In[' . matchstr(l:fold_text, '\d\+') . ']:'
  elseif l:fold_text =~# '```{.json .output n='
    let l:code_cell = 'Out[' . matchstr(l:fold_text, '\d\+') . ']:'
  else
    let l:code_cell = 'In[]:'
  endif
  return l:code_cell
endfunction

" Fold python's input and output cells using marker
" (you should not change the folding method!)
setlocal foldmethod=marker
setlocal foldmarker=```{.,```

setlocal foldtext=CellFoldingNaming()

" If deoplete present try to load custom jedi source
if exists('g:loaded_deoplete')
  try
    call deoplete#custom#source('jedi', 'filetypes', ['ipynb'])
  catch
    echoerr "Unable to load deoplete-jedi source, maybe it wasn't installed?"
  endtry
endif
