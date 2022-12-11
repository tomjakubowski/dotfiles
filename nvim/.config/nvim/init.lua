-- Following this guide to port
-- https://www.notonlycode.org/neovim-lua-config/

-- disable netrw, per lir reccos
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- this binding is annoying to lose when config is broken, so define it early
vim.cmd([[let mapleader=","]])
vim.cmd([[nnoremap <leader>ev :tabedit $MYVIMRC<CR>:tcd %:h<CR>]])

function setopts(opts)
	-- setopts({"foo", xwidth=1})
	for k, v in pairs(opts) do
		if type(k) == "string" then
			vim.opt[k] = v
		elseif type(k) == "number" and type(v) == "string" then
			vim.opt[v] = true
		end
	end
end

setopts({ "ignorecase", "smartcase", "expandtab" })
setopts({ tabstop = 2, softtabstop = 2, shiftwidth = 2 })
vim.opt.formatoptions:append("n")
vim.opt.formatoptions:remove("t")
setopts({ textwidth = 80 })

setopts({ "termguicolors" })
vim.opt.guicursor = "n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor"

-- TODO: tpope makes the great point that defaulting to Github is bad.  Fix that
local Plug = vim.fn["plug#"]
local stdpath = vim.fn["stdpath"]
vim.call("plug#begin", stdpath("data") .. "/plugged")
-- base libraries
Plug("nvim-lua/plenary.nvim")

-- eye candy
Plug("junegunn/goyo.vim")
Plug("andersevenrud/nordic.nvim")

-- file/project management
Plug("tamago324/lir.nvim")
Plug("c-brenn/fuzzy-projectionist.vim")
Plug("tpope/vim-projectionist")

-- fzf
Plug("junegunn/fzf", { dir = "~/.local/fzf", ["do"] = "./install --all" })
Plug("junegunn/fzf.vim")

-- git
Plug("tpope/vim-fugitive")
Plug("shumphrey/fugitive-gitlab.vim")

-- lightline
Plug("itchyny/lightline.vim")
Plug("nvim-lua/lsp-status.nvim")

-- lsp
Plug("jose-elias-alvarez/null-ls.nvim")
Plug("lukas-reineke/lsp-format.nvim")
Plug("neovim/nvim-lspconfig")
Plug("liuchengxu/vista.vim")
Plug("josa42/nvim-lightline-lsp")
Plug("ray-x/lsp_signature.nvim")

-- text editing
Plug("tpope/vim-commentary")
Plug("windwp/nvim-autopairs")
Plug("RRethy/nvim-treesitter-endwise")
Plug("tpope/vim-surround")
Plug("wellle/targets.vim")

-- text navigation
Plug("tpope/vim-unimpaired")

-- treesitter
Plug("nvim-treesitter/nvim-treesitter", { ["do"] = ":TSUpdate" })
Plug("nvim-treesitter/nvim-treesitter-textobjects")

-- ZZZZ miscellany

Plug("elixir-editors/vim-elixir")
Plug("leafgarland/typescript-vim")

Plug("rust-lang/rust.vim")
Plug("tikhomirov/vim-glsl")
Plug("tpope/vim-sensible")
Plug("Vimjas/vim-python-pep8-indent")

Plug("elixir-lsp/elixir-ls", {
	["do"] = function()
		vim.call("g:ElixirLS.compile()")
	end,
})
vim.call("plug#end")

-- autopairs
-- NOTABENE: when setting up nvim-cmp, consult nvim-autopairs README
-- for compatibility concerns
-- endwise is configured using the treesitter-endwise plugin, see treesitter.lua
require("nvim-autopairs").setup({})

vim.cmd([[
" presentation
set title
"set number
set numberwidth=3
" set relativenumber
set nowrap
set colorcolumn=+0
set signcolumn=yes
set showtabline=2 " always show tab line

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
nnoremap <leader>ed :tabedit<CR>:tcd ~/dotfiles<CR>:GitFiles --cached --other --exclude-standard<CR>
nnoremap <leader>el :tabedit<CR>:tcd ~/.config/nvim/lua<CR>:Files<CR>
nnoremap <leader>ev :tabedit $MYVIMRC<CR>:tcd %:h<CR>

" set options
nnoremap <leader>sn :set number!<CR>
nnoremap <leader>rn :set relativenumber!<CR>

inoremap <F2> <C-O>:set paste!<CR>
nnoremap <F2> :set paste!<CR>
nnoremap <F5> :make<CR>
" nnoremap <C-x><C-j> :NERDTree %:h<CR>
" nnoremap <C-x><C-j> :NvimTreeToggle %:h<CR>
" nnoremap <C-x><C-j> :lua toggle_replace()<CR>
nnoremap <C-f> :Buffers<CR>
" List project files
nnoremap <C-p> :Files<CR>

" INSERT mode
" uppercase current word.  thanks, steve losh!
inoremap <c-u> <esc>viwUgi

" VISUAL mode
" source line under file
vnoremap <leader>vs y:@"<CR>

" fzf
augroup fzf
  autocmd!
  autocmd FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END

autocmd FileType gitcommit :inoremap <buffer> <C-c><C-c> <esc>:wq<cr>
autocmd FileType gitcommit :nnoremap <buffer> <C-c><C-c> :wq<cr>
" FIXME: the next one should be doable without a recursive mapping
autocmd FileType fugitive :nmap <buffer> <tab> =

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
]])
require("tjak.lightline")
require("tjak.lir")
require("tjak.lsp")
require("tjak.treesitter")

require("nordic").colorscheme({
	italic = true,
})

vim.cmd([[
" Some commands
command! ChaseLink execute 'file' resolve(expand('%'))

command! Scratch lua require'tjak.tools'.makeScratch()
]])
