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
if executable('python3')
    let g:python3_host_prog = exepath('python3')
endif
if executable('python')
    let g:python_host_prog = exepath('python')
endif

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

" Enhanced Status Line Configuration
let g:airline_extensions = ['branch', 'fugitive', 'hunks', 'tabline', 'whitespace']

" Unicode symbols
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.colnr = ' '
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'

" Tabline configuration
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1

" Branch extension
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#format = 2

" Fugitive extension
let g:airline#extensions#fugitive#enabled = 1

" Hunks extension (GitGutter integration)
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 1

" Whitespace extension
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#whitespace#symbol = '!'

" Custom sections for better information display
let g:airline_section_x = airline#section#create(['filetype', ' ', 'fileencoding', ' ', '%{&fileformat}'])
let g:airline_section_y = airline#section#create(['%{strftime("%H:%M")}', ' ', 'branch'])
let g:airline_section_z = airline#section#create(['%3p%%', ' ', 'linenr', ':', '%3v'])

" Always show status line
set laststatus=2

" Enable airline clock extension
let g:airline#extensions#clock#enabled = 1
let g:airline#extensions#clock#format = '%H:%M:%S'

" FZF
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" GitGutter
let g:gitgutter_enabled = 1
let g:gitgutter_signs = 1
