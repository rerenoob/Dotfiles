set number
syntax on
set autoindent
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set clipboard=unnamed

call plug#begin()
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } 
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
call plug#end()
