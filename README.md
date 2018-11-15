## Work on the next version began, post your feature ideas [here](https://github.com/szymonmaszke/vimpyter/issues/17)

# vimpyter

<p align="center">
  <img src="https://user-images.githubusercontent.com/20703378/36676899-203f63f8-1b0d-11e8-9d28-6360ee3c181b.png" height=200/> 
  <img src="https://user-images.githubusercontent.com/20703378/36676906-238b0b34-1b0d-11e8-86dd-30695296e7c6.png" width=200/>
</p>

- **Input/output cells** are displayed using **custom syntax** file and **folding**.
- See your edits by starting **Jupyter Notebook/Nteract** application with **single command/mapping** (just remember to save your modifications). You may have to reload browser page/app to see the effects.
- To see **other features** click **[here](https://github.com/vyzyv/vimpyter/blob/master/doc/vimpyter.txt)**

## Demo
![gif](https://user-images.githubusercontent.com/20703378/36789762-f2bca936-1c92-11e8-92f7-c8bf9bede802.gif)

**[Jupyter preview & more](https://github.com/vyzyv/vimpyter/issues/3)**

## Installation

**Vim8 or Neovim is required (asynchronous features)**

Install required external dependency:

- **[notedown](https://github.com/aaren/notedown)**

Install plugin using plugin manager like **[vim-plug](https://github.com/junegunn/vim-plug)** or **[Vundle](https://github.com/VundleVim/Vundle.vim)**:

```vim
Plug 'szymonmaszke/vimpyter' "vim-plug
Plugin 'szymonmaszke/vimpyter' "Vundle
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

## Options

Following options are provided:

- **g:vimpyter_color**: display command line output in colour (0 or 1)
- **g:vimpyter_jupyter_notebook_flags**: string describing flags passed to Jupyter notebook
- **g:vimpyter_nteract_flags**: string describing flags passed to nteract app
- **g:vimpyter_view_directory**: directory where proxy files are created (default: ```$TMP```)

For detailed description type in your editor ```:help vimpyter-options```

## Integrations with other plugins

Currently supported plugins:

- **[Shougo/deoplete](https://github.com/Shougo/deoplete.nvim)**: asynchronous completion framework for Vim/Neovim. You have to install and configure **[zchee/deoplete-jedi](https://github.com/zchee/deoplete-jedi)** for python completions.


You can request additional integrations or create them on your own (**pull requests are welcomed**).

## Contributors wanted!

Things you could do to improve this software:

**Integrations with other plugins**:
- **[davidhalter/jedi-vim](https://github.com/davidhalter/jedi-vim)**: Things like go to definition and documentation, maybe autocompletion (available as choice instead of **deoplete-jedi**).
- **[w0rp/ale](https://github.com/w0rp/ale)**: Linting/fixing of .ipynb file. Using linters like flake8 from python or maybe custom made linter/fixer specifically for .ipynb file.

**Other improvements**:
- **Automatically update notebook on save**: See **[this issue](https://github.com/vyzyv/vimpyter/issues/4)** for more informations
- **Completion from ipython console**: It may be faster to use this one. Check **[jonathanslenders/ptpython](https://github.com/jonathanslenders/ptpython)** for possibilities.

## Known bugs

- **[nteract crashes on startup](https://github.com/nteract/nteract/issues/2582#issuecomment-368308596)** (usually does not occure)

If you find other bugs please post an issue. If you want to improve this software do not hesitate to cooperate!
