syntax enable
set number
set showcmd
set cursorline
set wildmenu
se lazyredraw
set showmatch
set path+=**

set wildmenu

set incsearch 
set hlsearch

set tabstop=2
set softtabstop=2
set expandtab
set shiftwidth=2

inoremap jk <esc>

set backspace=indent,eol,start

filetype plugin indent on
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'https://github.com/sheerun/vim-polyglot.git'
Plug 'scrooloose/nerdtree'
Plug 'bling/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'bling/vim-bufferline'
Plug 'joegesualdo/jsdoc.vim'
Plug 'https://github.com/pangloss/vim-javascript.git'
Plug 'https://github.com/w0ng/vim-hybrid.git'
Plug 'vim-scripts/Ambient-Color-Scheme'
Plug 'pangloss/vim-javascript'
Plug 'sjl/badwolf'
Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue'] }
call plug#end()

let g:javascript_plugin_jsdoc = 1
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.
