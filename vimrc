"-------------------------------------------------------------------------------
" Vim Customization:
"-------------------------------------------------------------------------------

"be iMproved
set nocompatible

filetype plugin on

" Custom file types
au! BufNewFile, BufRead *.rs setf rust
au! BufNewFile, BufRead *.elm setf elm
au! BufNewFile, BufRead *.ts setf typescript
au! BufNewFile, BufRead *.ex,*.exs setf elixir

" Set Leader Key
let mapleader = " "

" Set Local Leader Key
let maplocalleader = ","

"-------------------------------------------------------------------------------
" Plugins
"-------------------------------------------------------------------------------

call plug#begin('~/.vim/plugged')

" Colors
Plug 'chriskempson/base16-vim'
Plug 'flazz/vim-colorschemes'

" Editing
Plug 'AndrewRadev/splitjoin.vim'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'jiangmiao/auto-pairs'
Plug 'jszakmeister/vim-togglecursor'
Plug 'junegunn/goyo.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'junegunn/vim-easy-align', {'on': ['<Plug>(EasyAlign)', 'EasyAlign']}
Plug 'sjl/vitality.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'
if !has('nvim')
  Plug 'tpope/vim-sensible'
endif
Plug 'tpope/vim-surround'
Plug 'xuhdev/vim-latex-live-preview'

" Status
Plug 'bling/vim-airline'

" Tmux
Plug 'tpope/vim-tbone'

" Browsing/Navigation
Plug 'blueyed/vim-diminactive'
Plug 'christoomey/vim-tmux-navigator'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'justinmk/vim-gtfo'
Plug 'pbrisbin/vim-mkdir'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'gregsexton/gitv', {'on': 'Gitv'}
Plug 'mattn/gist-vim', {'on': 'Gist'}
Plug 'tpope/vim-fugitive'

" Linting and autocompletion
if !has('nvim')
  Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
endif
Plug 'davidhalter/jedi-vim', {'for': 'python'}
Plug 'w0rp/ale'

" Lang
Plug 'ap/vim-css-color'
Plug 'plasticboy/vim-markdown'
Plug 'posva/vim-vue'
Plug 'ElmCast/elm-vim', {'for': 'elm'}
Plug 'Quramy/tsuquyomi', {'for': 'typescript'}
Plug 'leafgarland/typescript-vim', {'for': 'typescript'}
Plug 'lervag/vimtex', {'for': 'latex'}
Plug 'pangloss/vim-javascript', {'for': 'javascript'}
Plug 'racer-rust/vim-racer', {'for': 'rust'}
Plug 'rust-lang/rust.vim', {'for': 'rust'}
Plug 'tpope/vim-fireplace', {'for': 'clojure'}
Plug 'tpope/vim-rails', {'for': 'ruby'}
Plug 'vim-ruby/vim-ruby', {'for': 'ruby'}
Plug 'elixir-lang/vim-elixir', {'for': 'elixir'}
Plug 'slashmili/alchemist.vim', {'for': 'elixir'}


call plug#end()

"-------------------------------------------------------------------------------
" Vim Looks:
"-------------------------------------------------------------------------------

" Font
set guifont=Menlo:h14

" Syntax highlighting
syntax enable

" Color
colorscheme Tomorrow

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
set list listchars=tab:»·

" Highlight lines over 80 chars
set textwidth=80
set colorcolumn=+1

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

set laststatus=2

" Only highlight the current line
set cursorline

" Resize window size with arrow keys
nnoremap <silent> <up>    :res -5 <CR>
nnoremap <silent> <down>  :res +5 <CR>
nnoremap <silent> <right> :vertical resize +5 <CR>
nnoremap <silent> <left>  :vertical resize -5 <CR>

" let netrw/Expolrer
let g:netrw_liststyle=3
noremap <leader>n :Explore<CR>

"-------------------------------------------------------------------------------
" Vim Search:
"-------------------------------------------------------------------------------

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

"-------------------------------------------------------------------------------
" Vim Movement:
"-------------------------------------------------------------------------------

" Move better between lines
map j gj
map k gk

" Move between splits with ctrl+direction
nmap <c-j> <c-w>j
nmap <c-k> <c-w>k
nmap <c-h> <c-w>h
nmap <c-l> <c-w>l

"-------------------------------------------------------------------------------
" Vim Other:
"-------------------------------------------------------------------------------


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


" Show matching brackets when on them
set showmatch
set mat=2

" Remove Error bells
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


" Enable spelling for some files
autocmd BufRead, BufNewFile *.md, *.markdown, *.tex setlocal spell spelllang=en_ca

" ----------------------------------------------------------------------------
" Plugin Configurations:
" ----------------------------------------------------------------------------

" ctrlp.vim
let g:ctrlp_working_path_mode = 'a'
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

" vim-airline
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

" deoplete.nvim
let g:deoplete#enable_at_startup = 1

" jedi-vim
let g:jedi#use_splits_not_buffers = 'bottom'

" vim-latex-live-preview
let g:livepreview_previewer = 'open -a Preview'

" tsuquyomi
let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_typescript_checkers = ['tsuquyomi']
" rename symobols
autocmd FileType typescript nmap <buffer> <Leader>e <Plug>(TsuquyomiRenameSymbol)
" symbols hints
autocmd FileType typescript nmap <buffer> <Leader>t : <C-u>echo tsuquyomi#hint()<CR>

" vim-commentry
autocmd FileType matlab setlocal commentstring=%\ %s

" ----------------------------------------------------------------------------
" NEOVIM Configurations:
" ----------------------------------------------------------------------------
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
