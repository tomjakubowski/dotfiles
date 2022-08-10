set smartcase

" tabs spaces wrapping
set expandtab
set tabstop=2 softtabstop=2 shiftwidth=2
set formatoptions+=n

set termguicolors
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor

let g:lightline = {}
" lightline config
" {{{
" -- INSERT -- is redundant
set noshowmode
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
      \ 'gitbranch': 'FugitiveHead'
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
call plug#begin(stdpath('data').'/plugged')
" {{{
  " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  " Plug 'Shougo/echodoc.vim'
  " TODO: ultisnip
  Plug 'arcticicestudio/nord-vim'
  Plug 'cespare/vim-toml'
  Plug 'c-brenn/fuzzy-projectionist.vim'
  Plug 'cstrahan/vim-capnp'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'elixir-editors/vim-elixir'
  Plug 'dag/vim-fish'
  Plug 'fatih/vim-go'
  Plug 'Glench/Vim-Jinja2-Syntax'
  Plug 'hashivim/vim-terraform'
  Plug 'hrsh7th/nvim-compe'
  Plug 'itchyny/lightline.vim'
  Plug 'junegunn/fzf', { 'dir': '~/.local/fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/goyo.vim'
  Plug 'lifepillar/vim-solarized8'
  Plug 'liuchengxu/vista.vim'
  Plug 'leafgarland/typescript-vim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'maximbaz/lightline-ale'
  Plug 'lukas-reineke/lsp-format.nvim'
  Plug 'preservim/nerdtree'
  Plug 'rstacruz/vim-closer'
  Plug 'rust-lang/rust.vim'
  Plug 'shaunsingh/nord.nvim'
  Plug 'shumphrey/fugitive-gitlab.vim'
  Plug 'sirver/ultisnips'
  Plug 'tikhomirov/vim-glsl'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-projectionist'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
  Plug 'Vimjas/vim-python-pep8-indent'
  Plug 'wellle/targets.vim'
  Plug 'zchee/vim-flatbuffers'

  Plug 'elixir-lsp/elixir-ls', { 'do': { -> g:ElixirLS.compile() } }
" }}}
call plug#end()

" presentation
set title
" set number
" set numberwidth=3
" set relativenumber
set nowrap
set colorcolumn=+0
set signcolumn=yes
set showtabline=2 " always show tab line

let [g:nord_italic, g:nord_underline] = [1, 1]
let g:nord_bold_vertical_split_line = 1
" let g:nord_uniform_diff_background = 1
set background=dark
colorscheme nord

if $TERM == "xterm-kitty"
  set termguicolors
  hi! Normal ctermbg=NONE guibg=NONE
  hi! NonText ctermbg=NONE guibg=NONE
endif

set completeopt-=preview
set completeopt+=longest

let mapleader=","
let maplocalleader="\\"

" Folding
set foldmethod=indent
" I'll override this for certain file types
set foldlevelstart=99
nnoremap <Space> za
" Make Y consistent with C and D.
nnoremap Y y$

" buffers
set hidden

" Enable GUI mouse behavior
set mouse=a

" Use ripgrep
if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
  let $FZF_DEFAULT_COMMAND='rg --follow --files --hidden --glob "!.git"'
endif

" NORMAL mode
" <leader>H to show hidden chars
nnoremap <leader>H :set list!<CR>
nnoremap <leader>r :Rg <C-r>=expand('<cword>')<CR>
nnoremap <leader>R :Rg <C-r>=expand('<cWORD>')<CR>

nnoremap <leader>o :copen<CR>

" edit files
nnoremap <leader>ev :tabedit $MYVIMRC<CR>:tcd %:h<CR>
nnoremap <leader>ed :tabedit<CR>:tcd ~/dotfiles<CR>:GitFiles --cached --other --exclude-standard<CR>

" set options
nnoremap <leader>sn :set number!<CR>

" ale bindings {{{
" nnoremap <leader>ah :ALEHover<CR>
" nnoremap <leader>gg :ALEGoToDefinition<CR>
" nnoremap <leader>gT :tab ALEGoToDefinition<CR>
" nnoremap <leader>? :ALEDetail<CR>
" nnoremap <silent> ]E :ALENext -error<cr>
" nnoremap <silent> [E :ALEPrevious -error<cr>
" nnoremap <silent> ]W :ALENext -warning<cr>
" nnoremap <silent> [W :ALEPrevious -warning<cr>
" }}}

nnoremap <F5> :make<CR>
nnoremap <C-x><C-j> :NERDTree %:h<CR>
nnoremap <C-f> :Buffers<CR>
" List project files
nnoremap <C-p> :Files<CR>

" INSERT mode
" uppercase current word.  thanks, steve losh!
inoremap <c-u> <esc>viwUgi

" VISUAL mode
" source line under file
vnoremap <leader>vs y:@"<CR>

" ale
let g:ale_fix_on_save = 1
" todo: set linters / fixers here rather than in ftplugins
let g:ale_linters = {
      \ 'elixir': [],
      \ 'javascript': ['eslint'],
      \ 'python': ['pyls', 'flake8', 'pylint'],
      \ 'shell': ['shellcheck'],
      \ 'typescript': ['eslint', 'tslint']
      \}
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'elixir': ['mix_format'],
      \ 'javascript': ['prettier'],
      \ 'python': ['yapf', 'black'],
      \ 'rust': ['rustfmt'],
      \ 'typescript': ['prettier']
      \}

" let g:ale_elixir_elixir_ls_release = expand("~/opt/elixir-ls")
" let g:ale_elixir_elixir_ls_config = {
"       \ 'elixirLS': { 'dialyzerEnabled': v:false }
"       \ }

let g:ale_open_list = 0
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_virtualtext_cursor = 1
let g:ale_rust_rustfmt_options = '--edition 2018'

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

augroup tf
  autocmd!
  autocmd FileType tf set commentstring=;\ %s
augroup END

" Open all file arguments in tabs
tab all

" Configure fugitive
let g:fugitive_gitlab_domains = ['https://git.2nd.io']

" ElixirLS
let g:ElixirLS = {}
let ElixirLS.path = stdpath('data').'/plugged/elixir-ls'
let ElixirLS.lsp = ElixirLS.path.'/release/language_server.sh'
let ElixirLS.cmd = join([
        \ 'mix do',
        \ 'local.hex --force --if-missing,',
        \ 'local.rebar --force,',
        \ 'deps.get,',
        \ 'compile,',
        \ 'elixir_ls.release',
        \ ], ' ')

function ElixirLS.on_stdout(_job_id, data, _event)
  let self.output[-1] .= a:data[0]
  call extend(self.output, a:data[1:])
endfunction

let ElixirLS.on_stderr = function(ElixirLS.on_stdout)

function ElixirLS.on_exit(_job_id, exitcode, _event)
  if a:exitcode[0] == 0
    echom '>>> ElixirLS compiled'
  else
    echoerr join(self.output, ' ')
    echoerr '>>> ElixirLS compilation failed'
  endif
endfunction

function ElixirLS.compile()
  let me = copy(g:ElixirLS)
  let me.output = ['']
  echom '>>> compiling ElixirLS'
  let me.id = jobstart('cd ' . me.path . ' && git pull && ' . me.cmd, me)
endfunction

" configure LSPs
lua <<EOF
local nvim_lsp = require('lspconfig')
require("lsp-format").setup {}

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  require("lsp-format").on_attach(client)
end

local servers = { 'rust_analyzer', 'tsserver', 'elixirls' }
local server_opts = {
  elixirls = {
    cmd = { vim.g.ElixirLS.lsp },
    settings = { ['elixirLS.dialyzerEnabled'] = false },
  }
}
for _, lsp in ipairs(servers) do
  local opts = {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
  for k, v in pairs(server_opts[lsp] or {}) do
    opts[k] = v
  end
  nvim_lsp[lsp].setup(opts)
end

EOF

" Some commands
command ChaseLink execute 'file' resolve(expand('%'))
