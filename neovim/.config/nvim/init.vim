inoremap jk <Esc>
set nu
set tabstop=2
set expandtab
set shiftwidth=2
set path+=**
set wildignore+=**/node_modules/**


set shortmess+=c
inoremap <c-c> <ESC>
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")


call plug#begin('~/.local/share/nvim/plugged')
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANTE: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect


Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-tern', {'do': 'npm install'}
Plug 'mhartington/nvim-typescript', {'for': 'typescript'}
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'prettier/vim-prettier'
Plug 'https://github.com/tpope/vim-sensible.git'
Plug 'othree/yajs.vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'majutsushi/tagbar'

" Initialize plugin system
call plug#end()

