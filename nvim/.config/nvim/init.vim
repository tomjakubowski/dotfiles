" general
set noswapfile
set smartcase

set expandtab
set tabstop=2 softtabstop=2 shiftwidth=2

" Plugins
call plug#begin('~/.local/share/nvim/plugged')
  Plug 'arcticicestudio/nord-vim'
  Plug 'cespare/vim-toml'
  Plug 'fatih/vim-go'
  Plug 'itchyny/lightline.vim'
  Plug 'junegunn/fzf', { 'dir': '~/.local/fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/goyo.vim'
  Plug 'neomake/neomake'
  Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
  Plug 'rust-lang/rust.vim'
  Plug 'skywind3000/asyncrun.vim'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
call plug#end()

" presentation
set number
set numberwidth=3
set relativenumber
set nowrap
set colorcolumn=100
set signcolumn=yes
colorscheme nord
if exists('g:lightline_colorscheme')
  let g:lightline.colorscheme = 'nord'
endif
let [g:nord_italic, g:nord_underline] = [1, 1]
if $TERM == "xterm-kitty"
  set termguicolors
endif

" buffers
set hidden

" Enable GUI mouse behavior
set mouse=a

" Use ripgrep
if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
endif

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
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>ev :tabedit $MYVIMRC<CR>
nnoremap <leader>g :silent lgrep<Space>
nnoremap <F5> :make<CR>
nnoremap <C-x><C-j> :Explore<CR>
nnoremap <C-f> :Buffers<CR>
nnoremap <C-p> :GitFiles -co --exclude-standard<CR>
" emacs-compatible bindings <3
nnoremap <C-x>b :Buffers<CR>
nnoremap <C-x><C-f> :Buffers<CR>

" uppercase current word.  thanks, steve losh!
inoremap <c-u> <esc>viwUgi

" neomake
call neomake#configure#automake('nw', 750)
let g:neomake_html_enabled_makers = []

" rust
let g:rustfmt_autosave = 1
let g:coc_global_extensions = ["coc-rls"]

" neovim terminal setup
augroup terminal_etc
  au! 
  autocmd TermOpen * setlocal nonumber norelativenumber
augroup END

" fzf
augroup fzf
  autocmd! 
  autocmd FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END

" netrw
let g:netrw_sort_sequence="[\/]$,*"
let g:netrw_list_hide='^\.git$'

" asyncrun
let g:asyncrun_open = 0
" vim-fugitive integration
" broken, doesn't refresh status window 
"command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>

autocmd FileType gitcommit :inoremap <buffer> <C-c><C-c> <esc>:wq<cr>
autocmd FileType gitcommit :nnoremap <buffer> <C-c><C-c> :wq<cr>
" FIXME: the next one should be doable without a recursive mapping
autocmd FileType fugitive :nmap <tab> =

autocmd BufNewFile,BufRead buildshim,buildshim-osx set ft=sh
