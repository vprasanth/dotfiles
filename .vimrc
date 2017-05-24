syntax enable
set t_Co=256
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

set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4

inoremap jk <esc>

set backspace=indent,eol,start

" vundle configuration
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" install these plugins
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'quramy/tsuquyomi'
Plugin 'bling/vim-airline'
Plugin 'airblade/vim-gitgutter'
Plugin 'shougo/vimproc.vim'
Plugin 'bubujka/emmet-vim'
Plugin 'scrooloose/syntastic'
Plugin 'leafgarland/typescript-vim'
Plugin 'scrooloose/vim-fugitive'
Plugin 'pangloss/vim-javascript'
Plugin 'flazz/vim-colorschemes'

call vundle#end()
filetype plugin indent on

