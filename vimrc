" Map alt modifier
execute "set <M-j>=\ej"
execute "set <M-k>=\ek"
execute "set <M-l>=\el"
execute "set <M-h>=\eh"

let mapleader=" "
set nocompatible
set number
set relativenumber
set virtualedit=onemore
set backspace=indent,eol,start
set showmode
set showcmd
set autoread
set nofoldenable
set path+=**
set clipboard=unnamedplus
set wildmenu
set noerrorbells
set noswapfile
set nobackup
set nowritebackup
set encoding=UTF-8
set laststatus=2
set lazyredraw
set hidden
set ruler
set fileformats=unix,dos,mac
set incsearch
set hlsearch
set ignorecase
set smartcase
set ttyfast
set nocursorcolumn
set nocursorline
set conceallevel=0
set nowrap
set textwidth=80
set autoindent
set smartindent
set showmatch
set smarttab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set signcolumn=yes
set complete-=i
set complete=.,w,b,u,t
set modelines=0
set nomodeline
set background=dark
syntax on
nnoremap $ $l

" stuff to ignore when tab completing
set wildignore=*.o,*.obj,*~
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif
" set colorscheme based on opera colorscheme existance
if !empty(globpath(&rtp, 'colors/opera.vim'))
  colorscheme opera
else
  colorscheme habamax
endif

" from this: https://vi.stackexchange.com/questions/454/whats-the-simplest-way-to-strip-trailing-whitespace-from-all-lines-in-a-file
function! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
command! TrimWhitespace call TrimWhitespace()
nnoremap <C-f> :call TrimWhitespace()<CR>

" clear highlights
nnoremap <leader>h :noh<CR>

" move between panes
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" move lines on normal & visual mode using alt
nnoremap <M-j> :m+1<CR>
nnoremap <M-k> :m-2<CR>
nnoremap <M-h> <<
nnoremap <M-l> >>
xnoremap <M-j> :move '>+1<CR>gv-gv
xnoremap <M-k> :move '<-2<CR>gv-gv
xnoremap <M-h> <gv
xnoremap <M-l> >gv
