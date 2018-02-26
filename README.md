# vimpyter

<p align="center">
  <img src="https://user-images.githubusercontent.com/20703378/36676899-203f63f8-1b0d-11e8-9d28-6360ee3c181b.png" height=200/> 
  <img src="https://user-images.githubusercontent.com/20703378/36676906-238b0b34-1b0d-11e8-86dd-30695296e7c6.png" width=200/>
</p>

**Edit Jupyter notebooks in your favourite editor (yeah, vim or neovim)**

## Demo

## Installation

To install this plugin you should use plugin manager like **[vim-plug](https://github.com/junegunn/vim-plug)** or **[Vundle](https://github.com/VundleVim/Vundle.vim)**:

```vim
Plug 'vyzyv/vimpyter' "vim-plug
Plugin 'vyzyv/vimpyter' "Vundle
```

If you want to use different plugin manager/direct instalation please do refer to their respective repositories/documentation.

**Make sure you have the required dependencies**

## Dependencies

- **Vim8 with asynchronous support or neovim**
- **[notedown](https://github.com/aaren/notedown)**

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

## Integrations with other plugins

Currently supported plugins:

- [w0rp/ale](https://github.com/w0rp/ale): asynchronous linter and fixer for Vim/Neovim
- [Shougo/deoplete](https://github.com/Shougo/deoplete.nvim): asynchronous completion framework for Vim/Neovim. You have to install and configure [zchee/deoplete-jedi](https://github.com/zchee/deoplete-jedi) for python completions.

You can request additional integrations or create them on your own (**pull requests are welcomed**)

## Known bugs

- [nteract crashes on startup](https://github.com/nteract/nteract/issues/2582#issuecomment-368308596)
- **Saving file and leaving immediately deletes the original file.** You can artificially wait after save for some time (e.g. 1 second) and quit afterwards. If you lose your file anyway (you did not read the known bugs) **don't panic**. Just go to your /tmp directory (or anything you've set with variable ```g:vimpyter_view_directory```) and find the file named path_to_original_file.ipynb (with underscores instead of slashes). Afterwards convert it to jupyter using [notedown](https://github.com/aaren/notedown) (see their README for details).

If you find other bugs please post an issue. Help with resolving the existing ones is **more than welcomed**.


