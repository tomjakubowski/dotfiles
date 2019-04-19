" general
set noswapfile
set smartcase

set expandtab
set tabstop=2 softtabstop=2 shiftwidth=2

" Plugins
call plug#begin('~/.local/share/nvim/plugged')
  Plug 'arcticicestudio/nord-vim'
  Plug 'neomake/neomake'
  Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
  Plug 'neoclide/coc-rls'
  Plug 'rust-lang/rust.vim'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-unimpaired'
  Plug 'vim-airline/vim-airline'
call plug#end()

" presentation
set nowrap
set colorcolumn=89
set signcolumn=yes
colorscheme nord
let g:nord_italic = 1
let g:nord_underline = 1
if &term == "xterm-kitty"
  set termguicolors
endif

" buffers
set hidden

" Enable GUI mouse behavior
set mouse=a

" Use ripgrep
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case

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
nnoremap <leader>g :silent lgrep<Space>
nnoremap <F5> :Neomake<CR>

set pastetoggle=<F2>

" Live reload vimrc
augroup reload_vimrc
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END
"
" neomake
call neomake#configure#automake('nw', 750)

" rust
let g:rustfmt_autosave = 1
