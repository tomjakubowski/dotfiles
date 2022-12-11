-- configure LSPs
require("lsp-format").setup({
	typescript = {
		exclude = { "tsserver" },
		order = { "null-ls" },
	},
})

require("lsp_signature").setup({
	-- hint_enable = false,
})

-- Configure keybindings for LSPs.  Should normally not be used with null-ls
local lsp_on_attach = function(_client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	-- local function buf_set_option(...)
	-- 	vim.api.nvim_buf_set_option(bufnr, ...)
	-- end

	-- omnifunc, tagfnc, formatexpr automatically set when feature is provided
	-- by language server

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
		lsp_formatting(client, bufnr)
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
lspconfig["svelte"].setup({
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
		-- Elixir 1.13 doesn't support --stdin-filename
		-- But it's necessary when using a project with .formatter.exs
		-- in a subdirectory
		args = { "format", "-", "--stdin-filename", "$FILENAME" },
	}),
	null_ls.builtins.formatting.prettier.with({
		condition = function(utils)
			return utils.root_has_file({ ".prettierignore " })
		end,
	}),
	null_ls.builtins.formatting.stylua,

	null_ls.builtins.diagnostics.credo.with({
		command = "credo",
		args = { "suggest", "--format", "json", "--read-from-stdin", "$FILENAME" },
		condition = function(utils)
			return utils.root_has_file({ ".credo.exs" })
		end,
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
