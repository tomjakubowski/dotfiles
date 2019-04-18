" general
set noswapfile
set smartcase

set expandtab
set tabstop=2 softtabstop=2 shiftwidth=2

" presentation
set nowrap
set colorcolumn=89
set signcolumn=yes

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

" Key mappings
let mapleader=","

" <leader>H to show hidden chars
nnoremap <leader>H :set list!<CR>
nnoremap <leader>V :tabedit $MYVIMRC<CR>
nnoremap <F5> :Neomake<CR>
set pastetoggle=<F2>

" Live reload vimrc
augroup reload_vimrc
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

" Plugins
call plug#begin('~/.local/share/nvim/plugged')
  " Automatically install missing plugins on startup
  if !empty(filter(copy(g:plugs), '!isdirectory(v:val.dir)'))
   autocmd VimEnter * PlugInstall | q
  endif
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-unimpaired'
  Plug 'neomake/neomake'
  Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
  Plug 'neoclide/coc-rls'
  Plug 'vim-airline/vim-airline'
call plug#end()

" neomake
call neomake#configure#automake('nw', 750)

