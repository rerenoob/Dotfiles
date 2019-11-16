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
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'dense-analysis/ale'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-airline/vim-airline'
call plug#end()
