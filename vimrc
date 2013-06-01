" Vundle settings:
"-----------------
"be iMproved
set nocompatible

" required from Vundle
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here ( original repos on github ):
"----------------------------------------------

Bundle 'gregsexton/MatchTag'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
Bundle 'kchmck/vim-coffee-script'
Bundle 'skammer/vim-css-color'
Bundle 'groenewege/vim-less'
Bundle 'vim-scripts/python.vim'
Bundle 'vim-ruby/vim-ruby'
Bundle 'slim-template/vim-slim'
Bundle 'godlygeek/tabular'
Bundle 'mattn/zencoding-vim'
Bundle 'scrooloose/syntastic'
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-surround'
Bundle 'bkad/CamelCaseMotion'

" end Vundle settings
"--------------------

" Vim Customization:
"-------------------

" LOOKS: 
"-------


" Font
set guifont=Menlo:h13

" Color
color Tomorrow-Night

" Syntax highliting 
syntax enable

" Show line numbers
set number

" Remove menu bar
set guioptions-=m

" Remove toolbar
set guioptions-=T

" Remove right/left-hand scroll bar
set guioptions-=r
set guioptions-=l

" Display current column and line number of cursor position
set ruler

" Cursor offset from bottom of page
set scrolloff=4


" end LOOKS
"----------


" Enable filtype plugins
filetype plugin indent on

" Automatically read the file again when it is changed outside of Vim
set autoread

" Set Leader Key
let mapleader = ","


" Edit a file without losing modifications to the current file
set hidden

" Remove files backup
set nobackup
set nowritebackup 

" Remove swap files
set noswapfile

" Searching:
"-----------


" Disable case sensitive
set ignorecase

" Ignore ignorecase option if search has Upper-Case charecters
set smartcase

" Incremntal search, find words as you type them
set incsearch

" Highlight Searches
set hlsearch

" Disable highlights after search
nmap <leader>q :nohlsearch<CR>

" RegEx in Search
set magic


" end Searching
"--------------

" Movement:
"-----------

" Move better between lines
map j gj
map k gk

" Move between splits with ctrl+direction
nmap <c-j> <c-w>j
nmap <c-k> <c-w>k
nmap <c-h> <c-w>h
nmap <c-l> <c-w>l



" end Movement
"--------------

" Show matching brackets when on them
set showmatch
set mat=2


" Remove Err bells
set noerrorbells
set novisualbell
set t_vb=
set tm=500


" Spaces instead of tabs
set expandtab

" Inserts blanks according to 'shiftwidth'
set smarttab

" Make 1 tab = 2 spaces
set shiftwidth=2
set tabstop=2
set softtabstop=2

" Use auto-indenting when moving into new lines
set autoindent

" Do smart autoindenting when starting a new line
set smartindent

" Round indent to multiple of 'shiftwidth'
set shiftround

" Resize window size with arrow keys
nnoremap <silent> <up>    :res -5 <CR>
nnoremap <silent> <down>  :res +5 <CR>
nnoremap <silent> <right> :vertical resize +5 <CR>
nnoremap <silent> <left>  :vertical resize -5 <CR>

" NERDTree plugin: Show directory explorer
noremap <leader>n :NERDTreeToggle<CR>

" Tabular plugin: Mapping
if exists(":Tabularize")
  nnoremap <leader>a= :Tab /=<CR>
  nnoremap <leader>as= :Tab /=\zs<CR>
  vnoremap <leader>a= :Tab /=<CR>
  vnoremap <leader>as= :Tab /=\zs<CR>
  nnoremap <leader>a: :Tab /:<CR>
  nnoremap <leader>as: :Tab /:\zs<CR>
  vnoremap <leader>a: :Tab /:<CR>
  vnoremap <leader>as: :Tab /:\zs<CR>
endif














