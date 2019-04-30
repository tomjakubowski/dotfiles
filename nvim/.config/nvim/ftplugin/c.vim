let b:ale_linters = ['cquery']

" http://clang.llvm.org/docs/ClangFormat.html#vim-integration
map <C-k> :pyf /usr/local/share/clang-format.py<cr>
imap <C-k> <C-o>:pyf /usr/local/share/clang-format.py<cr>

function! ClangFormatBuffer()
  pyf /usr/local/share/clang-format.py
endfunction

autocmd BufWritePre <buffer> call ClangFormatBuffer()
