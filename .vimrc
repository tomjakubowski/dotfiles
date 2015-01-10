set nocompatible

set autoindent
set backspace=indent,eol,start
set ruler
set showcmd
set incsearch
set hlsearch

execute pathogen#infect()

filetype plugin indent on

set nowrap
set hidden
set expandtab
set tabstop=4 softtabstop=4 shiftwidth=4
set whichwrap=b,s,<,>,[,]
set viminfo=
set modeline
set modelines=3
set mouse=a
set ttymouse=xterm2
set noerrorbells visualbell t_vb=
set esckeys

set laststatus=2

set exrc
set secure

syntax enable
set background=dark
let base16colorspace=256  " Access colors present in 256 colorspace
colorscheme base16-eighties
set colorcolumn=90

if has ('gui_running')
    set guioptions=acM
    set mousefocus
    set guifont=Tamsyn\ 9
    augroup gui
        autocmd!
        autocmd GUIEnter * set vb t_vb=
    augroup END
endif

" Strip trailing whitespace
function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and
  " cursor position
  let @/=_s
  call cursor(l, c)
endfunction

augroup all
    autocmd!
    autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
augroup END

let mapleader="\\"
nmap <leader>V :tabedit $MYVIMRC<CR>

" <leader>H to show hidden chars
nmap <leader>H :set list!<CR>
nmap <leader>M :make<CR>
nmap <silent> <leader>c :bp\|bd #<CR>

set foldmethod=manual
set nofoldenable

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files --exclude-standard -c -o .']
let g:ctrlp_custom_ignore = 'node_modules'

let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = ' -std=c++11'
