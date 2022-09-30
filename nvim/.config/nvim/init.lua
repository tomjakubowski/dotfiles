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

setopts({ "termguicolors" })
vim.opt.guicursor = "n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor"

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

-- lsp
Plug("jose-elias-alvarez/null-ls.nvim")
Plug("lukas-reineke/lsp-format.nvim")
Plug("neovim/nvim-lspconfig")
Plug("liuchengxu/vista.vim")
Plug("josa42/nvim-lightline-lsp")

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

-- lightline config
setopts({ showmode = false })
vim.g.lightline = {
	active = {
		left = { { "mode", "paste" }, { "filename" }, { "gitbranch" } },
		right = {
			{ "lineinfo" },
			{ "fileformat", "fileencoding", "filetype" },
			-- TODO: implement these
			-- {"lsp_info", "lsp_hints", "lsp_errors", "lsp_warnings", "lsp_ok"},
			{ "lsp_errors", "lsp_warnings", "lsp_ok" },
			{ "helloworld" },
		},
	},
	colorscheme = "nord", -- installed in my dotfiles
	component = {
		helloworld = "Hello, world!",
	},
	component_expand = {
		lsp_warnings = "lightline#lsp#warnings",
		lsp_errors = "lightline#lsp#errors",
		lsp_ok = "lightline#lsp#ok",
	},
	component_function = {
		gitbranch = "FugitiveHead",
	},
	component_type = {
		helloworld = "error",
		gitbranch = "left",
		lsp_warnings = "warning",
		lsp_errors = "error",
		lsp_ok = "right",
	},
}
reload_lightline()

local function setup_lir()
	local actions = require("lir.actions")
	require("lir").setup({
		show_hidden_files = false,
		mappings = {
			["<CR>"] = actions.edit,
			["<C-e>"] = actions.edit,
			["<C-s>"] = actions.split,
			["<C-v>"] = actions.vsplit,
			["<C-t>"] = actions.tabedit,

			["-"] = actions.up,
			["q"] = actions.quit,
		},
		hide_cursor = true,
		on_init = function()
			vim.api.nvim_echo({ { vim.fn.expand("%:p"), "Normal" } }, false, {})
		end,
	})
	vim.keymap.set("n", "<C-x><C-j>", "<Cmd>e %:h<CR>")
end
setup_lir()

-- autopairs
-- NOTA BENE: when setting up nvim-cmp, consult nvim-autopairs README
-- for compatibility concerns
-- endwise is configured using the treesitter-endwise plugin, see treesitter.lua
require("nvim-autopairs").setup({})

--   active = {
--     -- left = {{"mode", "paste"}, {"gitbranch", "readonly", "modified"}},
--     -- right = {
--     --   {"linter_checking", "linter_errors", "linter_warnings", "linter_ok"},
--     --   {"lineinfo"},
--     --   {"fileformat", "fileencoding", "filetype"}
--     -- },
--   },
--   -- component_function = {
--   --   gitbranch="FugitiveHead"
--   -- },
--   -- TODO: switch to LSP
--   component_expand = {
--     -- \ 'linter_checking': 'lightline#ale#checking',
--     -- \ 'linter_warnings': 'lightline#ale#warnings',
--     -- \ 'linter_errors': 'lightline#ale#errors',
--     -- \ 'linter_ok': 'lightline#ale#ok',
--   },
--   -- component_type = {
--   --   linter_checking='left',
--   --   linter_warnings='warning',
--   --   linter_errors='error',
--   --   linter_ok='left'
--   -- }
-- }

vim.cmd([[
" Plugins
" call plug#begin(stdpath('data').'/plugged')
" {{{
" }}}
"call plug#end()

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
]])

-- configure LSPs
local nvim_lsp = require("lspconfig")
require("lsp-format").setup({
	typescript = {
		exclude = { "tsserver" },
		order = { "null-ls" },
	},
})

-- Configure keybindings for LSPs.  Should normally not be used with null-ls
local lsp_on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	--Enable completion triggered by <c-x><c-o>
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- FIXME: Use vim.keymap
	local opts = { noremap = true, silent = true }
	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
end

-- Yay, debug logging
--vim.lsp.set_log_level("debug")
vim.lsp.set_log_level("info")

-- Configure formatting-on-save via lsp
local lsp_formatting = function(client, bufnr)
	local util = require("vim.lsp.util")
	-- Alternative to binding <cmd>lua vim.lsp.buf.formatting()<CR>
	vim.keymap.set("n", "<leader>f", function()
		local params = util.make_formatting_params({})
		client.request("textDocument/formatting", params, nil, bufnr)
	end, { buffer = bufnr })

	-- Format on save
	require("lsp-format").on_attach(client)
end

local lspconfig = require("lspconfig")
lspconfig["tsserver"].setup({
	on_attach = function(client, bufnr)
		lsp_on_attach(client, bufnr)
	end,
	flags = {
		debounce_text_changes = 150,
	},
})
lspconfig["elixirls"].setup({
	cmd = { vim.g.ElixirLS.lsp },
	settings = { elixirLS = { dialyzerEnabled = false } },
	on_attach = function(client, bufnr)
		lsp_on_attach(client, bufnr)
		-- sadly, formatting in ElixirLS is extremely broken at the moment
		-- using null_ls mix instead
		-- lsp_formatting(client, bufnr)
	end,
	flags = {
		debounce_text_changes = 150,
	},
})
lspconfig["rust_analyzer"].setup({
	on_attach = function(client, bufnr)
		lsp_on_attach(client, bufnr)
	end,
	flags = {
		debounce_text_changes = 150,
	},
})
lspconfig["pylsp"].setup({
	on_attach = function(client, bufnr)
		lsp_on_attach(client, bufnr)
		lsp_formatting(client, bufnr)
	end,
	flags = {
		debounce_text_changes = 150,
	},
})

-- null-ls handles running formatters/linters as an lsp
local null_ls = require("null-ls")
local sources = {
	null_ls.builtins.formatting.mix.with({
		-- removing --stdin-filename because Elixir 1.13 doesn't support it
		args = { "format", "-" },
	}),
	null_ls.builtins.formatting.prettier,
	null_ls.builtins.formatting.stylua,

	-- TODO: I should be able to enable/disable null_ls sources per project?
	null_ls.builtins.diagnostics.credo.with({
		command = "credo",
		args = { "suggest", "--format", "json", "--read-from-stdin", "$FILENAME" },
	}),
	null_ls.builtins.diagnostics.selene.with({
		cwd = function(_params)
			return vim.fs.dirname(
				vim.fs.find({ "selene.toml" }, { upward = true, path = vim.api.nvim_buf_get_name(0) })[1]
			) or vim.fn.expand("~/.config/selene/") -- fallback value
		end,
	}),
}
null_ls.setup({
	on_attach = function(client, bufnr)
		lsp_formatting(client, bufnr)
	end,
	sources = sources,
	debug = false,
})

require("treesitter")

require("nordic").colorscheme({
	italic = true,
})

function reload_lightline()
	vim.fn["lightline#init"]()
	vim.fn["lightline#colorscheme"]()
	vim.fn["lightline#update"]()
end

vim.cmd([[
" Some commands
command! ChaseLink execute 'file' resolve(expand('%'))

command! Scratch lua require'tools'.makeScratch()
]])
