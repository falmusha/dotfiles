" Vundle settings:
"-----------------
"be iMproved
set nocompatible

let s:darwin = has('mac')

call plug#begin('~/.vim/plugged')

" Colors
Plug 'flazz/vim-colorschemes'
Plug 'chriskempson/base16-vim'

" Edit
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-commentary'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'tpope/vim-sensible'
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'junegunn/goyo.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'jszakmeister/vim-togglecursor'
Plug 'jiangmiao/auto-pairs'
Plug 'craigemery/vim-autotag'

" Status
Plug 'bling/vim-airline'

" Tmux
Plug 'tpope/vim-tbone'

" Browsing/Navigation
Plug 'ctrlpvim/ctrlp.vim'
Plug 'pbrisbin/vim-mkdir'
Plug 'justinmk/vim-gtfo'
Plug 'christoomey/vim-tmux-navigator'
Plug 'blueyed/vim-diminactive'

" Git
Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv', {'on': 'Gitv'}
Plug 'mattn/gist-vim', {'on': 'Gist'}
Plug 'airblade/vim-gitgutter'

" Lint
Plug 'scrooloose/syntastic'

" Lang
if v:version >= 703
  Plug 'vim-ruby/vim-ruby', {'for': 'ruby'}
endif
Plug 'tpope/vim-fireplace', {'for': 'clojure'}
Plug 'pangloss/vim-javascript', {'for': 'javascript'}
Plug 'kchmck/vim-coffee-script'
Plug 'plasticboy/vim-markdown'
Plug 'tpope/vim-rails', {'for': []}
Plug 'ap/vim-css-color'
Plug 'rust-lang/rust.vim', {'for': 'rust'}
if s:darwin
  Plug 'rizzatti/dash.vim',  {'on': 'Dash'}
endif
Plug 'chrisbra/unicode.vim', {'for': 'journal'}
Plug 'posva/vim-vue'
Plug 'leafgarland/typescript-vim', {'for': 'typescript'}
Plug 'elixir-lang/vim-elixir'


call plug#end()


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

" Syntax highliting
syntax enable

" Color

" Switch color schemes for different file types
silent! :autocmd BufEnter,FileType *
\   if &ft ==# 'markdown' || &ft ==# 'md' | colorscheme Tomorrow |
\   elseif strftime("%H") >= 5 && strftime("%H") <= 17 | colorscheme Tomorrow |
\   else | colorscheme Tomorrow-Night |
\   endif

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

set laststatus=2

" Only highlight the current line
set cursorline


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

" let netrw/Expolrer
let g:netrw_liststyle=3
noremap <leader>n :Explore<CR>

" Enable spelling for some files
autocmd BufRead,BufNewFile *.md,*.markdown setlocal spell spelllang=en_us

" ----------------------------------------------------------------------------
" Plugin Confs
" ----------------------------------------------------------------------------

" syntastic plugin
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_typescript_checkers = []


" ctrlp plugin
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_root_markers = ['pom.xml']
let g:ctrlp_show_hidden = 1
" let g:ctrlp_use_caching = 1
" let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.class
set wildignore+=*/bower_components,*/node_modules,*/build,*/deps,*/_build
let g:ctrlp_custom_ignore = {
           \ 'dir':  '\v[\/]\.(git|hg|svn)$',
           \ 'file': '\v\.(exe|so|dll)$',
           \ 'link': 'some_bad_symbolic_links',
           \ }

" airline plugin
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#ctrlp#show_adjacent_modes = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing' ]

" vim-markdown
let g:vim_markdown_folding_disabled=1

" rust.vim
let g:rustfmt_autosave = 0
