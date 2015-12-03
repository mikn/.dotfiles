" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if has('vim_starting')
  if &compatible
    set nocompatible
  endif

  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'chriskempson/base16-vim'
NeoBundle 'bling/vim-airline'

call neobundle#end()

filetype plugin indent on
NeoBundleCheck

"""
" Basic settings
"""
syntax on
set nu

"""
" base16-vim
"""
let base16colorspace=256
colorscheme base16-default
set background=dark

"""
" vim-airline
"""
set laststatus=2
let g:airline_powerline_fonts = 1
