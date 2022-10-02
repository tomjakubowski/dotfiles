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

		["K"] = actions.mkdir,
		["N"] = actions.newfile,
		["R"] = actions.rename,
		["@"] = actions.cd,
		["Y"] = actions.yank_path,
		["."] = actions.toggle_show_hidden,
		["D"] = actions.delete,
	},
	hide_cursor = true,
	on_init = function()
		vim.api.nvim_echo({ { vim.fn.expand("%:p"), "Normal" } }, false, {})
	end,
})

vim.keymap.set("n", "<C-x><C-j>", "<Cmd>e %:h<CR>")
