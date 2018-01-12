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
  set nrformats=bin,hex
  set ruler
  set sessionoptions-=options
  set showcmd
  set smarttab
  set tabpagemax=50
  set tags=./tags;,tags
  set wildmenu
endif

"-------------------------------------------------------------------------------
" plugins
"-------------------------------------------------------------------------------

let s:plugged = !empty(glob('~/.vim/plugged'))

if s:plugged
  call plug#begin('~/.vim/plugged')

  " colors
  Plug 'chriskempson/base16-vim'

  " editing
  Plug 'tpope/vim-commentary'

  " languages support
  Plug 'elixir-editors/vim-elixir'
  Plug 'slashmili/alchemist.vim'

  call plug#end()
endif

"-------------------------------------------------------------------------------
" Looks
"-------------------------------------------------------------------------------

syntax manual " manual syntax highlighting (only enable in active buffers)
filetype plugin on " enable file type detection

let base16colorspace = 256 | colorscheme base16-ocean

"-------------------------------------------------------------------------------
" options
"-------------------------------------------------------------------------------

set colorcolumn=+1 " highlight lines over that 1 column after 'textwidth'
set expandtab " spaces instead of tabs
set list listchars=tab:»·,precedes:-,trail:·,nbsp:+
set noswapfile " remove swap files
set number " show line numbers
set shiftwidth=2 | set tabstop=2 " 1 tab = 2 spaces
set splitbelow " open new split panes to bottom
set splitright " open new split panes to right
set statusline=[%n]%f%m%r%w%=%y[%p%%][%l\/%L,%v]
set textwidth=80
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.class,*DS_Store* " general
set wildignore+=*bower_components/**,*node_modules/**,*build/**,*dist/** " JS
set wildignore+=*deps/**,*_build/** " elixir

augroup active_window
    autocmd!
    autocmd BufEnter * setlocal syntax=ON
    autocmd BufLeave * setlocal syntax=OFF
augroup END

"-------------------------------------------------------------------------------
" key mappings
"-------------------------------------------------------------------------------

let mapleader = " "
let maplocalleader = ","

" normal -----------------------------------------------------------------------

" remove trailing white spaces
nnoremap <leader>s :call StripTrailingWhitespace()<CR><Paste>

" increase height by 5 columns
nnoremap <silent> <DOWN> :resize -2 <CR>

" decrease height by 5 columns
nnoremap <silent> <UP> :resize +2 <CR>

" increase width by 5 columns
nnoremap <silent> <RIGHT> :vertical resize +5 <CR>

" decrease width by 5 columns
nnoremap <silent> <LEFT>  :vertical resize -5 <CR>

" quick fuzzy-ish edit
nnoremap <leader>e :edit **/

" qq to record, Q to replay
nnoremap Q @q

" disable highlights after search
nnoremap <leader>q :nohlsearch<CR>

" use - and | for horizontal or vertical splits
nnoremap \| :vsplit<CR>
nnoremap - :split<CR>

" open vimrc file to edit it
nnoremap <leader>ev :vsplit $MYVIMRC<CR>

" reload vimrc file
nnoremap <leader>sv :source $MYVIMRC<CR>

" insert -----------------------------------------------------------------------

" delete line when CTRL+d and enter insert mode at end of prev line
inoremap <C-d> <ESC>ddA

"-------------------------------------------------------------------------------
" helper functions
"-------------------------------------------------------------------------------

function! StripTrailingWhitespace()
  if !&binary && &filetype != 'diff'
    normal mz
    normal Hmy
    %s/\s\+$//e
    normal 'yz<CR>
    normal `z
  endif
endfunction

"-------------------------------------------------------------------------------
" FileType specific
"-------------------------------------------------------------------------------

augroup filetype_elixir
    autocmd!
    autocmd FileType elixir setlocal textwidth=98
augroup END
