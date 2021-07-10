set encoding=utf-8
syntax on
set number
set showcmd
set wildmenu
set lazyredraw
set showmatch
set path+=**
set t_Co=256

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
" Plug 'tpope/vim-sensible'
Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/nerdtree'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'bling/vim-bufferline'
Plug 'pangloss/vim-javascript'
Plug 'Quramy/tsuquyomi'
Plug 'prettier/vim-prettier', {
      \ 'do': 'npm install',
      \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue'] }
Plug 'vim-syntastic/syntastic'
Plug 'fatih/vim-go'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'wakatime/vim-wakatime'
Plug 'heavenshell/vim-jsdoc', { 
      \ 'for': ['javascript', 'javascript.jsx','typescript'], 
      \ 'do': 'make install'
      \}
Plug 'lifepillar/vim-mucomplete'
Plug 'airblade/vim-gitgutter'
call plug#end()

let g:javascript_plugin_jsdoc = 1
" let g:hybrid_custom_term_colors = 1
" let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.
let g:tsuquyomi_completion_detail = 0

let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
let g:SuperTabClosePreviewOnPopupClose = 1
let g:NERDTreeNodeDelimiter = "\u00a0"

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_typescript_checkers = ['tslint']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

let g:syntastic_mode_map = {
          \ "mode": "active",
    \ "passive_filetypes": ["env", "sh"] }

let g:syntastic_go_checkers = ['govet', 'errcheck', 'go']
let g:go_list_type = "quickfix"

autocmd FileType typescript nmap <buffer> <Leader>e <Plug>(TsuquyomiRenameSymbol)
autocmd FileType typescript nmap <buffer> <Leader>E <Plug>(TsuquyomiRenameSymbolC)
let g:airline_powerline_fonts = 1
let NERDTreeHijackNetrw=1

let g:dracula_italic = 0
set background=dark
color dracula

set completeopt+=menuone
set shortmess+=c
