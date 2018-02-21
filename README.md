# vimpyter

<p align="center">
  <img src="https://github.com/vyzyv/vimpyter/blob/master/images/jupyter_logo.png" height=200/> 
  <img src="https://github.com/vyzyv/vimpyter/blob/master/images/vim_logo.png" width=200/>
</p>

**Edit Jupyter notebooks in your favourite editor (yeah, vim or neovim)**

# Demo

# Installation

To install this plugin you should plugin manager like **[vim-plug](https://github.com/junegunn/vim-plug)** or **[Vundle](https://github.com/VundleVim/Vundle.vim)**:

```vim
Plug 'vyzyv/vimpyter' "vim-plug
Plugin 'vyzyv/vimpyter' "Vundle
```

If you want of to use different plugin manager/direct instalation please do refer to their respective repositories/documentation.

# Configuration

Plugin provides some convenience commands:

  - **VimpyterStartNotebook**: asynchronously starts jupyter notebook instance from Vim/Neovim
  - **VimpyterInsertPythonBlock**: inserts block of python code (see Demo)
  
Last two functions should be mapped to vim's autocommand or quit/close buffer operations as those are responsible for transformation between formats.

Example mappings (**put this in yout .vimrc/init.vim**):

```vim
autocmd Filetype jupyter nmap <silent><Leader>b :VimpyterInsertPythonBlock<CR>
autocmd Filetype python nmap <silent><Leader>j :VimpyterStartNotebook<CR>
```

# Dependencies

# Limitations
