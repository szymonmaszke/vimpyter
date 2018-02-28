# vimpyter

<p align="center">
  <img src="https://user-images.githubusercontent.com/20703378/36676899-203f63f8-1b0d-11e8-9d28-6360ee3c181b.png" height=200/> 
  <img src="https://user-images.githubusercontent.com/20703378/36676906-238b0b34-1b0d-11e8-86dd-30695296e7c6.png" width=200/>
</p>

**Edit Jupyter notebooks easily in your favourite editor!**

- **Input/output cells** are displayed using **custom syntax** file and **folding**.
- See your edits by starting **Jupyter Notebook/Nteract** application with **single command/mapping** (just remember to save your modifications). You may have to reload browser page/app to see the effects.

## Demo

**[More GIFs]('')**

## Installation

Install required external dependency:

- **[notedown](https://github.com/aaren/notedown)**

Install plugin using plugin manager like **[vim-plug](https://github.com/junegunn/vim-plug)** or **[Vundle](https://github.com/VundleVim/Vundle.vim)**:

```vim
Plug 'vyzyv/vimpyter' "vim-plug
Plugin 'vyzyv/vimpyter' "Vundle
```

If you want to use different plugin manager/direct instalation please do refer to their respective repositories/documentation.

## Configuration

Plugin provides some convenience commands:

  - **VimpyterStartJupyter**: asynchronously starts [jupyter notebook](http://jupyter.org) instance from Vim/Neovim
  - **VimpyterStartNteract**: asynchronously starts [nteract](https://github.com/nteract/nteract) instance from Vim/Neovim
  - **VimpyterInsertPythonBlock**: inserts block of python code (see Demo)

Example mappings (**put this in your .vimrc/init.vim**):

```vim
autocmd Filetype ipynb nmap <silent><Leader>b :VimpyterInsertPythonBlock<CR>
autocmd Filetype ipynb nmap <silent><Leader>j :VimpyterStartJupyter<CR>
autocmd Filetype ipynb nmap <silent><Leader>n :VimpyterStartNteract<CR>
```

To see all available flags/commands refer to [vim's documentation](https://github.com/vyzyv/vimpyter/blob/master/doc/vimpyter.txt)

## Integrations with other plugins

Currently supported plugins:

- **[Shougo/deoplete](https://github.com/Shougo/deoplete.nvim)**: asynchronous completion framework for Vim/Neovim. You have to install and configure **[zchee/deoplete-jedi](https://github.com/zchee/deoplete-jedi)** for python completions.
- **[davidhalter/jedi-vim](https://github.com/davidhalter/jedi-vim/issues/784#issuecomment-369015726)**: planned, see the issue

You can request additional integrations or create them on your own (**pull requests are welcomed**).

## Known bugs

- **[nteract crashes on startup](https://github.com/nteract/nteract/issues/2582#issuecomment-368308596)** (usually does not occure)

If you find other bugs please post an issue. If you want to improve this software do not hesitate to cooperate!
