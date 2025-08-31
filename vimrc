" Basic settings
set number
set relativenumber
syntax on
set autoindent
set smartindent
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set clipboard=unnamed
set tw=80
set formatoptions+=t
set formatoptions-=l
set mouse=a
set cursorline
set ignorecase
set smartcase
set incsearch
set hlsearch
set showmatch
set wildmenu
set scrolloff=8
set sidescrolloff=8
set backspace=indent,eol,start
autocmd FileType md,markdown setlocal spell spelllang=en_us

" automatically install vim-plug if not already installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" set up vimwiki
set nocompatible
filetype plugin indent on
let g:vimwiki_list = [{'path': '~/Documents/Notes/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

" Python settings for virtualenv
let g:python_host_prog = '/usr/bin/python3'
let g:python3_host_prog = '/usr/bin/python3'

" Key remappings
nnoremap j gj
nnoremap k gk
nnoremap <esc> :noh<return><esc>
" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" Quick save
nnoremap <Leader>w :w<CR>
" NERDTree toggle
nnoremap <Leader>t :NERDTreeToggle<CR>
" FZF shortcuts
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>r :Rg<CR>

call plug#begin()
" File management and navigation
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } 
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdcommenter'

" Git integration
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Editor enhancements
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'yuttie/comfortable-motion.vim'
Plug 'jiangmiao/auto-pairs'

" Language and syntax
Plug 'sheerun/vim-polyglot'

" Note-taking and documentation
Plug 'vimwiki/vimwiki'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'mattn/calendar-vim'

" Status line enhancements
Plug 'enricobacis/vim-airline-clock'
call plug#end()

" Plugin configurations
" NERDTree
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\~$', '\.swp$', '\.DS_Store$']

" Airline
let g:airline_theme='dark'
let g:airline_powerline_fonts=1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.branch = ''
let g:airline_symbols.dirty = '⚡'

" FZF
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" GitGutter
let g:gitgutter_enabled = 1
let g:gitgutter_signs = 1
