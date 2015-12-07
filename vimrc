" Vundle settings:
"-----------------
"be iMproved
set nocompatible

" required from Vundle
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'gmarik/Vundle.vim'

" My Bundles here ( original repos on github ):
"----------------------------------------------
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
Plugin 'skammer/vim-css-color'
Plugin 'godlygeek/tabular'
Plugin 'kien/ctrlp.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'bling/vim-airline'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-endwise'
Plugin 'mileszs/ack.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'Raimondi/delimitMate'
Plugin 'mattn/gist-vim'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'rust-lang/rust.vim'
Plugin 'pbrisbin/vim-mkdir'
Plugin 'vim-scripts/tComment'

call vundle#end()

" Enable filtype plugins
filetype plugin indent on

" end Vundle settings
"--------------------

" Vim Customization:
"-------------------

" LOOKS:
"-------


" Font
set guifont=Menlo:h14

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

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Highlight lines over 80 chars
set textwidth=80
set colorcolumn=+1

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" end LOOKS
"----------


" Set Leader Key
let mapleader = " "

" Automatically read the file again when it is changed outside of Vim
set autoread

" Edit a file without losing modifications to the current file
set hidden

" Remove files backup
set nobackup
set nowritebackup

" Remove swap files
set noswapfile

" Backspace deletes like most programs in insert mode
set backspace=2


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

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

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


" NERDTree plugin
" Show directory explorer
let NERDTreeHighlightCursorline=1
noremap <leader>n :NERDTreeToggle<CR>


" syntastic plugin recommendation
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" ctrlp
let g:ctrlp_working_path_mode = 'c'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
set wildignore+=*/bower_components,*/node_modules

" airline
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#ctrlp#show_adjacent_modes = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing' ]

" incsearch
let g:incsearch#auto_nohlsearch=1

set laststatus=2
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
