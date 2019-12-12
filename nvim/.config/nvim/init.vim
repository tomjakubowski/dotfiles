" general
set noswapfile
set smartcase

" tabs spaces wrapping
set expandtab
set tabstop=2 softtabstop=2 shiftwidth=2
set formatoptions+=n

let g:lightline = {}
" lightline config
" {{{
let g:lightline.colorscheme = 'nord'
let g:lightline.active = {}
let g:lightline.active.left = [
      \ ['mode', 'paste'],
      \ ['gitbranch', 'readonly', 'modified'],
      \ ]
let g:lightline.active.right = [
      \ ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok'],
      \ ['lineinfo'],
      \ ['fileformat', 'fileencoding', 'filetype'],
      \ ]
let g:lightline.component_function = {
      \ 'gitbranch': 'fugitive#head'
      \ }
let g:lightline.component_expand = {
      \ 'linter_checking': 'lightline#ale#checking',
      \ 'linter_warnings': 'lightline#ale#warnings',
      \ 'linter_errors': 'lightline#ale#errors',
      \ 'linter_ok': 'lightline#ale#ok',
      \ }
let g:lightline.component_type = {
      \ 'linter_checking': 'left',
      \ 'linter_warnings': 'warning',
      \ 'linter_errors': 'error',
      \ 'linter_ok': 'left',
      \ }
" }}}

" Plugins
call plug#begin('~/.local/share/nvim/plugged')
" {{{
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  " Plug 'Shougo/echodoc.vim'
  " TODO: ultisnip
  Plug 'arcticicestudio/nord-vim'
  Plug 'cespare/vim-toml'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'fatih/vim-go'
  Plug 'Glench/Vim-Jinja2-Syntax'
  Plug 'itchyny/lightline.vim'
  Plug 'junegunn/fzf', { 'dir': '~/.local/fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/goyo.vim'
  Plug 'liuchengxu/vista.vim'
  Plug 'leafgarland/typescript-vim'
  Plug 'maximbaz/lightline-ale'
  Plug 'rust-lang/rust.vim'
  Plug 'tikhomirov/vim-glsl'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
  Plug 'Vimjas/vim-python-pep8-indent'
  Plug 'wellle/targets.vim'
  Plug 'w0rp/ale'
  Plug 'zchee/vim-flatbuffers'
" }}}
call plug#end()

" presentation
set title
set number
set numberwidth=3
set relativenumber
set nowrap
set colorcolumn=+0
set signcolumn=yes
set showtabline=2 " always show tab line
let [g:nord_italic, g:nord_underline] = [1, 1]
let g:nord_bold_vertical_split_line = 1
let g:nord_uniform_diff_background = 1
colorscheme nord
if $TERM == "xterm-kitty"
  set termguicolors
  hi! Normal ctermbg=NONE guibg=NONE
  hi! NonText ctermbg=NONE guibg=NONE
endif

set completeopt-=preview
set completeopt+=noinsert

let mapleader=","

" Folding
set foldmethod=indent
" I'll override this for certain file types
set foldlevelstart=99
nnoremap <Space> za
nnoremap <Space> za

" buffers
set hidden

" Enable GUI mouse behavior
set mouse=a

" Use ripgrep
if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
  let $FZF_DEFAULT_COMMAND='rg --files --hidden -g "!.git"'
endif

" NORMAL mode
" <leader>H to show hidden chars
nnoremap <leader>H :set list!<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>ev :tabedit $MYVIMRC<CR>:tcd %:h<CR>

nnoremap <leader>o :copen<CR>
nnoremap <leader>ah :ALEHover<CR>
nnoremap <leader>g :ALEGoToDefinition<CR>
nnoremap <leader>? :ALEDetail<CR>
nnoremap <silent> ]E :ALENext -error<cr>
nnoremap <silent> [E :ALEPrevious -error<cr>
nnoremap <silent> ]W :ALENext -warning<cr>
nnoremap <silent> [W :ALEPrevious -warning<cr>

nnoremap <F5> :make<CR>
nnoremap <C-x><C-j> :Explore<CR>
nnoremap <C-f> :Buffers<CR>
nnoremap <C-p> :Files<CR>
" emacs-compatible bindings <3
nnoremap <C-x>b :Buffers<CR>
nnoremap <C-x><C-f> :Files<CR>

" INSERT mode
" uppercase current word.  thanks, steve losh!
inoremap <c-u> <esc>viwUgi

" ale
let g:ale_fix_on_save = 1
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \}
let g:ale_open_list = 0
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
" fzf
augroup fzf
  autocmd!
  autocmd FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END

" deoplete
let g:deoplete#enable_at_startup = 1
if exists("g:deoplete#custom#source")
  call g:deoplete#custom#source('_',
    \ 'max_menu_width', 0)
endif
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" echodoc
let g:echodoc#enable_at_startup = 1

" netrw
let g:netrw_sort_sequence="[\/]$,*"
let g:netrw_list_hide='^\.git$'

autocmd FileType gitcommit :inoremap <buffer> <C-c><C-c> <esc>:wq<cr>
autocmd FileType gitcommit :nnoremap <buffer> <C-c><C-c> :wq<cr>
" FIXME: the next one should be doable without a recursive mapping
autocmd FileType fugitive :nmap <buffer> <tab> =

augroup svelte
  autocmd!
  autocmd BufNewFile,BufRead *.svelte set ft=html
  autocmd BufNewFile,BufRead *.svelte let b:ale_linters = []
augroup END

" Open all file arguments in tabs
tab all
