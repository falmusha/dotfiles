"-------------------------------------------------------------------------------
" ~Mostly~ Behave like neovim 
"-------------------------------------------------------------------------------

if !has('nvim')
  set autoindent
  set autoread
  set backspace=indent,eol,start
  set belloff=all
  set complete=.,w,b,u,t
  set display=lastline
  set formatoptions=tcqj
  set history=10000
  set hlsearch
  set incsearch
  set langnoremap
  set laststatus=2
  set list listchars=tab:»·,trail:-,nbsp:+
  set nocompatible
  set nrformats=bin,hex
  set ruler
  set sessionoptions-=options
  set showcmd
  set smarttab
  set t_Co=256
  set tabpagemax=50
  set tags=./tags;,tags
  set ttyfast
  set wildmenu
endif

syntax enable " syntax highlighting
filetype plugin on " enable file type detection

"-------------------------------------------------------------------------------
" Plugins
"-------------------------------------------------------------------------------

call plug#begin('~/.vim/plugged')

Plug 'elixir-editors/vim-elixir'

call plug#end()

"-------------------------------------------------------------------------------
" Options
"-------------------------------------------------------------------------------

set colorcolumn=+1 " highlight lines over that 1 column after 'textwidth' 
set expandtab " spaces instead of tabs
set noswapfile " remove swap files
set number " show line numbers
set shiftwidth=2 | set tabstop=2 " 1 tab = 2 spaces
set splitbelow " open new split panes to bottom
set splitright " open new split panes to right
set statusline=[%n]%f%m%r%w%=%y[%p%%][%l\/%L,%v]
set textwidth=80
  
"-------------------------------------------------------------------------------
" Key Mappings 
"-------------------------------------------------------------------------------

let mapleader = " "
let maplocalleader = ","

" Modal Mappings ---------------------------------------------------------------

" disable highlights after search
nnoremap <leader>q :nohlsearch<CR>

" use - and | for horizontal or vertical splits
nnoremap \| :vsplit<CR>
nnoremap - :split<CR>

" open vimrc file to edit it
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" reload vimrc file
nnoremap <leader>sv :source $MYVIMRC<cr>

" Insert Mappings ---------------------------------------------------------------

" delete line when CTRL+d and enter insert mode at end of prev line
inoremap <c-d> <esc>ddA

"-------------------------------------------------------------------------------
" FileType specific
"-------------------------------------------------------------------------------

augroup filetype_elixir
    autocmd!
    autocmd FileType elixir setlocal textwidth=98
augroup END
