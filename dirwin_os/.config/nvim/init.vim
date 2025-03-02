set autoindent expandtab tabstop=4 shiftwidth=4
set autoread
set ignorecase
set iskeyword-=_
set langmenu=en_US.UTF-8
set mouse=a
set nowrap
set number
set relativenumber
set shell=zsh

autocmd InsertEnter * set norelativenumber
autocmd InsertLeave * set relativenumber

"" Searching
set hlsearch                      " highlight matches
set incsearch                     " incremental searching
set ignorecase                    " searches are case insensitive...
set smartcase                     " ... unless they contain at least one capital letter
set gdefault                      " have :s///g flag by default on

" --- theme ---
:colorscheme murphy
" :colorscheme habamax
" :colorscheme vim

" Shortcut keys
" For normal mode
nnoremap <C-c> :set clipboard=unnamedplus<CR>
nnoremap :q :q!
nnoremap mm :! 
nnoremap mn :Explore<CR>

nnoremap x "_x
vnoremap x "_x

" For insert mode
inoremap ( ()<Esc>i
inoremap { {}<Esc>i
inoremap [ []<Esc>i
inoremap " ""<Esc>i
inoremap ' ''<Esc>i
inoremap ` ``<Esc>i
