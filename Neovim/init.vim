call plug#begin()
Plug 'rakr/vim-one'
Plug 'sheerun/vim-polyglot'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdcommenter'
call plug#end()

" Keybindings
inoremap <C-j> <ESC>
nmap <C-f> :set nohlsearch<CR>
vmap <C-f> :set nohlsearch<CR>
imap <C-f> :set nohlsearch<CR>
nmap <C-q> :q<CR>
nmap <C-s> :w<CR>

" Comment lines
nmap ++ <plug>NERDCommenterToggle
vmap ++ <plug>NERDCommenterToggle

" Line numbers
set number relativenumber

" Use mouse to navigate
set mouse=a

" Disable line wrapping
set nowrap

" Theme

if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
  set termguicolors
endif

autocmd VimEnter * highlight Normal guibg=#282C34
set background=dark
colorscheme one

