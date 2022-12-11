au BufNewFile,BufRead *.exs.sample set filetype=elixir

" nnoremap <leader>tt :execute "!mix test %:" .. line(".")<CR>
nnoremap <leader>tf :vsplit \| terminal mix test %<CR>
nnoremap <leader>tt :execute "vsplit \| terminal mix test %:" . line(".")<CR>
