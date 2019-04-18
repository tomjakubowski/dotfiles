" init.vim

" general
set syntax
set noswapfile
set smartcase

set expandtab
set tabstop=2 softtabstop=2 shiftwidth=2
set shada

" presentation
set nowrap
set colorcolumn=89

" buffers
set hidden

" Enable GUI mouse behavior
set mouse=a

" If using Oni's externalized statusline, hide vim's native statusline, 
if exists('g:gui_oni')
  set noshowmode
  set noruler
  set laststatus=0
  set noshowcmd
endif

" Mappings

let mapleader=","

" <leader>H to show hidden chars
nmap <leader>H :set list!<CR>
nmap <leader>M :make<CR>
nmap <leader>V :tabedit $MYVIMRC<CR>
