set encoding=utf-8
syntax on
set number
set showcmd
set wildmenu
set lazyredraw
set showmatch
set path+=**
" set t_Co=256
set re=0

set incsearch 
set hlsearch

set expandtab
set shiftwidth=2
set softtabstop=2
inoremap jk <esc>
set textwidth=80
set colorcolumn=80
set wrap linebreak nolist

set backspace=indent,eol,start

filetype plugin indent on
call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'tpope/vim-sensible'
Plug 'voldikss/vim-floaterm'
Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/nerdtree'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'bling/vim-bufferline'
Plug 'pangloss/vim-javascript'
Plug 'prettier/vim-prettier', {
      \ 'do': 'npm install',
      \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'html'] }
Plug 'vim-syntastic/syntastic'
Plug 'fatih/vim-go'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'wakatime/vim-wakatime'
"Plug 'lifepillar/vim-mucomplete'
Plug 'airblade/vim-gitgutter'
Plug 'f-person/git-blame.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
call plug#end()

let g:javascript_plugin_jsdoc = 1
" let g:hybrid_custom_term_colors = 1
" let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.
"let g:tsuquyomi_completion_detail = 0

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

"autocmd FileType typescript nmap <buffer> <Leader>e <Plug>(TsuquyomiRenameSymbol)
"autocmd FileType typescript nmap <buffer> <Leader>E <Plug>(TsuquyomiRenameSymbolC)
let g:airline_powerline_fonts = 1
let NERDTreeHijackNetrw=1

" theme!!
let g:dracula_italic = 0
set background=dark
color dracula
" colorscheme onehalfdark
let g:airline_theme='dracula'

set completeopt+=menuone
set shortmess+=c

" floaterm setup
let g:floaterm_keymap_new = '<Leader>ft'
let g:floaterm_autoclose = 2


" coc-ts config
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
let g:airline#extensions#coc#enabled = 1
let g:gitblame_ignored_filetypes = ['nerdtree']
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
setlocal spell spelllang=en_us
