:set number
:set autoread
:set nowrap
:set mouse=a
:set relativenumber
:set autoindent expandtab tabstop=4 shiftwidth=4

autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber

" :set guicursor=n-v-c-i:block

" :colorscheme jellybeans
" :colorscheme atom
:colorscheme murphy

" Shortcut keys
" For normal mode
nnoremap <C-c> :set clipboard=unnamedplus<CR>
nnoremap :q :q!

" For insert mode
inoremap ( ()<Esc>i
inoremap { {}<Esc>i
inoremap [ []<Esc>i
inoremap " ""<Esc>i
inoremap ' ''<Esc>i
inoremap ` ``<Esc>i
