"-------------------------------------------------------------------------------
" Vim Customization:
"-------------------------------------------------------------------------------

"be iMproved
set nocompatible

set t_Co=256

filetype plugin on

" Custom file types
au! BufNewFile, BufRead *.rs setf rust
au! BufNewFile, BufRead *.elm setf elm
au! BufNewFile, BufRead *.ts setf typescript

" Set Leader Key
let mapleader = " "

" Set Local Leader Key
let maplocalleader = ","

let base16colorspace=256

"-------------------------------------------------------------------------------
" Plugins
"-------------------------------------------------------------------------------

call plug#begin('~/.vim/plugged')

" Colors
Plug 'chriskempson/base16-vim'
Plug 'flazz/vim-colorschemes'
Plug 'powerman/vim-plugin-AnsiEsc'

" Editing
Plug 'AndrewRadev/splitjoin.vim'
Plug 'Shougo/vimproc.vim',      { 'do' : 'make' }
Plug 'jiangmiao/auto-pairs'
Plug 'jszakmeister/vim-togglecursor'
Plug 'ntpeters/vim-better-whitespace'
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'sjl/vitality.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'
if !has('nvim')
  Plug 'tpope/vim-sensible'
endif
Plug 'tpope/vim-surround'
Plug 'xuhdev/vim-latex-live-preview'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Status
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'


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
Plug 'gregsexton/gitv', { 'on': 'Gitv' }
Plug 'mattn/gist-vim',  { 'on': 'Gist' }
Plug 'tpope/vim-fugitive'

" Linting and autocompletion
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
endif
Plug 'davidhalter/jedi-vim',   { 'for': 'python' }
Plug 'w0rp/ale'
Plug 'prettier/vim-prettier', { 'do': 'npm install', 'for': ['javascript',
      \  'typescript', 'css', 'less', 'scss', 'json', 'graphql'] }

" Writing
Plug 'reedes/vim-pencil'
Plug 'reedes/vim-lexical'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
Plug 'bilalq/lite-dfm'
Plug 'tpope/vim-markdown'

" Lang
Plug 'ap/vim-css-color'
Plug 'posva/vim-vue'
Plug 'ElmCast/elm-vim',            { 'for': 'elm' }
Plug 'Quramy/tsuquyomi',           { 'for': 'typescript' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'lervag/vimtex',              { 'for': 'tex' }
Plug 'pangloss/vim-javascript',    { 'for': 'javascript' }
Plug 'racer-rust/vim-racer',       { 'for': 'rust' }
Plug 'rust-lang/rust.vim',         { 'for': 'rust' }
Plug 'tpope/vim-fireplace',        { 'for': 'clojure' }
Plug 'tpope/vim-rails',            { 'for': 'ruby' }
Plug 'vim-ruby/vim-ruby',          { 'for': 'ruby' }
Plug 'elixir-lang/vim-elixir',     { 'for': ['elixir', 'eelixir'] }
Plug 'slashmili/alchemist.vim',    { 'for': ['elixir', 'eelixir'] }
Plug 'dart-lang/dart-vim-plugin',  { 'for': 'dart' }


call plug#end()

"-------------------------------------------------------------------------------
" Vim Looks:
"-------------------------------------------------------------------------------

" Font
set guifont=Menlo:h14

" Syntax highlighting
syntax enable

" Color
colorscheme base16-ocean

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

" jj in insert mode to exit insert mode
imap jj <Esc>

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

" Writing settings
au FileType * if &filetype =~ 'mkd\|markdown' | call WritingMode() | endif
noremap <leader>w :call WritingMode()<CR>

function! WritingMode()
  set spell spelllang=en_ca
  setlocal guifont=Menlo:h16
  Goyo
endfunction

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
let g:airline_theme='base16'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#ctrlp#show_adjacent_modes = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing' ]

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

" vim-pencil
let g:pencil#wrapModeDefault = 'soft'
let g:pencil#autoformat = 0
let g:pencil#textwidth = 110

augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init()
  autocmd FileType text         call pencil#init()
augroup END

" goyo
let g:goyo_width = 100
let g:goyo_height = '100%'

function! s:goyo_enter()
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
  Limelight
endfunction

function! s:goyo_leave()
  Limelight!
  " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
endfunction

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()

" ----------------------------------------------------------------------------
" NEOVIM Configurations:
" ----------------------------------------------------------------------------
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
