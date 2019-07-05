" general
set noswapfile
set smartcase

" tabs spaces wrapping
set expandtab
set tabstop=2 softtabstop=2 shiftwidth=2
set formatoptions+=n

" Plugins
call plug#begin('~/.local/share/nvim/plugged')
  " TODO: ultisnip, deoplete
  Plug 'arcticicestudio/nord-vim'
  Plug 'cespare/vim-toml'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'fatih/vim-go'
  Plug 'itchyny/lightline.vim'
  Plug 'junegunn/fzf', { 'dir': '~/.local/fzf', 'do': './install --all' }
  Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/goyo.vim'
  Plug 'leafgarland/typescript-vim'
  Plug 'rust-lang/rust.vim'
  Plug 'tikhomirov/vim-glsl'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
  Plug 'wellle/targets.vim'
  Plug 'w0rp/ale'
call plug#end()

" presentation
set title
set number
set numberwidth=3
set relativenumber
set nowrap
set colorcolumn=+0
set signcolumn=yes
colorscheme nord
if exists('g:lightline_colorscheme')
  let g:lightline.colorscheme = 'nord'
endif
let [g:nord_italic, g:nord_underline] = [1, 1]
if $TERM == "xterm-kitty"
  set termguicolors
endif

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
nnoremap <leader>g :silent lgrep<Space>
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
let g:ale_disable_lsp = 1

" LanguageClient-neovim
let g:LanguageClient_serverCommands = {
  \ 'cpp': ['ccls'],
  \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
  \ }
nnoremap <F6> :call LanguageClient_contextMenu()<CR>

" fzf
augroup fzf
  autocmd!
  autocmd FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END

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
