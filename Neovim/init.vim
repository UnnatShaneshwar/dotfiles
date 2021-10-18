call plug#begin()
Plug 'rakr/vim-one'
Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/nerdcommenter'
call plug#end()
" Keybindings
inoremap <C-j> <ESC>

nmap <C-f> :set nohlsearch<CR>
vmap <C-f> :set nohlsearch<CR>

nmap <C-q> :q<CR>
nmap <C-s> :w<CR>

nmap <C-m> :set nonumber norelativenumber<CR>

nmap <C-e> :Vexplore<CR>

nmap <C-p> :edit 

nmap <C-h> :split<CR>
nmap <C-n> :vsplit<CR>

" Comment lines
nmap ++ <plug>NERDCommenterToggle
vmap ++ <plug>NERDCommenterToggle

" Line numbers
set number relativenumber

" Show indent lines
set list
set listchars=tab:\│\ ,

" Use mouse to navigate
"set mouse=a

" Restore cursor theme on exit
augroup RestoreCursorShapeOnExit
    autocmd!
    autocmd VimLeave * set guicursor=a:ver20-blinkwait400-blinkoff400-blinkon400
augroup END

" Disable line wrapping
set nowrap

" Theme

if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
  set termguicolors
endif

" Use Terminal background color
autocmd VimEnter * hi Normal guibg=NONE ctermbg=NONE

set background=dark
colorscheme one

