vim.keymap.set("n", "<F5>", "<Cmd>%so<CR>")
-- this is buggy - it uses the _previous_ selection
-- rewrite it as lua to read the text using nvim_buf_get_mark and
-- then pass to :source
vim.keymap.set("v", "<F5>", "<Cmd>'<,'>so<CR>")
