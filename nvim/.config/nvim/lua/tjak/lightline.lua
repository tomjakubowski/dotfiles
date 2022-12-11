local M = {}

-- TODO: Consider using https://github.com/nvim-lua/lsp-status.nvim

-- lightline config
require("tjak").setopts({ showmode = false })

--   active = {
--     -- left = {{"mode", "paste"}, {"gitbranch", "readonly", "modified"}},
--     -- right = {
--     --   {"linter_checking", "linter_errors", "linter_warnings", "linter_ok"},
--     --   {"lineinfo"},
--     --   {"fileformat", "fileencoding", "filetype"}
--     -- },
--   },

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
		helloworld = "keep on keeping on",
	},
	component_expand = {
		lsp_clients = "lightline#lsp#clients",
		-- this function seems to not be defined?
		-- lsp_status = "lightline#lsp#status",
		lsp_warnings = "lightline#lsp#warnings",
		lsp_errors = "lightline#lsp#errors",
		lsp_ok = "lightline#lsp#ok",
	},
	component_function = {
		gitbranch = "FugitiveHead",
	},
	component_type = {
		helloworld = "left",
		gitbranch = "left",
		lsp_warnings = "warning",
		lsp_errors = "error",
		lsp_ok = "right",
	},
}

M.reload = function()
	vim.fn["lightline#init"]()
	vim.fn["lightline#colorscheme"]()
	vim.fn["lightline#update"]()
end

M.reload()

return M
