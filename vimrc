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

  Plug 'airblade/vim-gitgutter'
  Plug 'chriskempson/base16-vim'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'elixir-editors/vim-elixir'
  Plug 'flazz/vim-colorschemes'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/goyo.vim'
  Plug 'junegunn/limelight.vim'
  Plug 'mhartington/oceanic-next'
  Plug 'prettier/vim-prettier', { 'do': 'npm install' }
  Plug 'sbdchd/neoformat'
  Plug 'sheerun/vim-polyglot'
  Plug 'slashmili/alchemist.vim'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-vinegar'
  Plug 'w0rp/ale'

  call plug#end()
endif

"-------------------------------------------------------------------------------
" Looks
"-------------------------------------------------------------------------------

syntax manual " manual syntax highlighting (only enable in active buffers)
filetype plugin on " enable file type detection

colorscheme Tomorrow-Night
"-------------------------------------------------------------------------------
" options
"-------------------------------------------------------------------------------

set colorcolumn=+1 " highlight lines over that 1 column after 'textwidth'
set expandtab " spaces instead of tabs
set list listchars=tab:»·,precedes:-,trail:·,nbsp:+
set noswapfile " remove swap files
set number relativenumber " show line numbers
set shiftwidth=2 | set tabstop=2 " 1 tab = 2 spaces
set splitbelow " open new split panes to bottom
set splitright " open new split panes to right
set statusline=[%n]%f%m%r%w%=[%{fugitive#head()}]%y[%p%%][%l\/%L,%v]
set textwidth=80
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.class,*DS_Store* " general
set wildignore+=*bower_components/**,*node_modules/**,*build/**,*dist/** " JS
set wildignore+=*deps/**,*_build/** " elixir

"-------------------------------------------------------------------------------
" key mappings
"-------------------------------------------------------------------------------

let mapleader = " "
let maplocalleader = ","

" normal -----------------------------------------------------------------------

" move between splits with CTRL + hjkl
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" move up and down a wrapped line
nnoremap j gj
nnoremap k gk

" increase height by 5 columns
nnoremap <silent> <DOWN> :resize -2 <CR>

" decrease height by 5 columns
nnoremap <silent> <UP> :resize +2 <CR>

" increase width by 5 columns
nnoremap <silent> <RIGHT> :vertical resize +5 <CR>

" decrease width by 5 columns
nnoremap <silent> <LEFT>  :vertical resize -5 <CR>

" repeat last commnad
nnoremap <leader>lc @:

" got to last buffer
nnoremap <leader>lb :b#<CR>

" remove trailing white spaces
nnoremap <leader>s :call StripTrailingWhitespace()<CR><Paste>

" start rgrep find command
nnoremap <leader>g :Rg<SPACE>

" rgrep on current word
nnoremap <leader>G :execute 'Rg ' expand('<cword>')<CR>

" quick fuzzy-ish edit
nnoremap <leader>e :edit **/

" disable highlights after search
nnoremap <leader>q :nohlsearch<CR>

" open vimrc file to edit it
nnoremap <leader>ev :vsplit $MYVIMRC<CR>

" reload vimrc file
nnoremap <leader>sv :source $MYVIMRC<CR>

" use - and | for horizontal or vertical splits
nnoremap \| :vsplit<CR>
nnoremap - :split<CR>

" qq to record, Q to replay
nnoremap Q @q

" open FZF fuzzy file finder
nnoremap <C-p> :Files<CR>

" format current buffer using Neoformat
nnoremap <leader>f :Neoformat<CR>

" enable spelling
nnoremap <C-s> :setlocal spell! spelllang=en_ca<CR>

" insert -----------------------------------------------------------------------

" delete line when CTRL+d and enter insert mode at end of prev line
inoremap <C-d> <ESC>ddA

" disable ESC in insert mode
inoremap <ESC> <NOP>

" leave insert mode
inoremap jj <ESC>

" disable arrow keys in insert mode
inoremap <UP> <NOP>
inoremap <DOWN> <NOP>
inoremap <LEFT> <NOP>
inoremap <RIGHT> <NOP>

" terminal ---------------------------------------------------------------------

if has('nvim')
  tnoremap jj <C-\><C-n>
endif

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

function! EnterBuf()
  setlocal syntax=ON

  if &filetype != 'markdown'
    setlocal relativenumber
  endif
endfunction

function! LeaveBuf()
  setlocal syntax=OFF

  if &filetype != 'markdown'
    setlocal norelativenumber
  endif
endfunction

function! EnterInsert()
  if &filetype != 'markdown'
    setlocal relativenumber
  endif
endfunction

function! LeaveInsert()
  if &filetype != 'markdown'
    setlocal norelativenumber
  endif
endfunction

"-------------------------------------------------------------------------------
" auto commands
"-------------------------------------------------------------------------------

augroup active_window
  autocmd!
  autocmd BufEnter * call EnterBuf()
  autocmd BufLeave * call LeaveBuf()
augroup END

augroup line_number
  autocmd!
  autocmd InsertLeave * call EnterInsert()
  autocmd InsertEnter * call LeaveInsert()
augroup END

" FileType specific ------------------------------------------------------------

augroup filetype_elixir
  autocmd!
  autocmd FileType elixir,eelixir setlocal textwidth=98
augroup END

augroup filetype_markdown
  autocmd!
  autocmd FileType markdown setlocal textwidth=120
  autocmd FileType markdown setlocal spell spelllang=en_ca
  autocmd FileType markdown :Goyo 121
augroup END

"-------------------------------------------------------------------------------
" plugins customization
"-------------------------------------------------------------------------------

" fzf.vim ----------------------------------------------------------------------

let g:fzf_layout = { 'down': '~20%' }

" customize fzf colors to match color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" use ripgrep instead of ag:
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:80%')
  \           : fzf#vim#with_preview('right:50%'),
  \   <bang>0)

" preview :Files
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" limelight.vim ----------------------------------------------------------------

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" source local machine specific vimrc
if !empty(glob('~/.vimrc.local'))
  source ~/.vimrc.local
endif
