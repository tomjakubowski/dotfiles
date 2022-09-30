local M = {}

-- lightline config
require("tjak").setopts({ showmode = false })

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

M.reload = function()
	vim.fn["lightline#init"]()
	vim.fn["lightline#colorscheme"]()
	vim.fn["lightline#update"]()
end

M.reload()

return M
