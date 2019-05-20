let b:ale_linters = ['cquery']
let b:ale_fixers = ['clang-format']

" TODO: a fun project would be to turn this into an ALE fixer, to preserve the
" cursor position and whatnot.
function! ClangFormatBuffer()
  pyf /usr/local/share/clang-format.py
endfunction

" http://clang.llvm.org/docs/ClangFormat.html#vim-integration
" map <C-k> :pyf /usr/local/share/clang-format.py<cr>
" imap <C-k> <C-o>:pyf /usr/local/share/clang-format.py<cr>

" autocmd BufWritePre <buffer> call ClangFormatBuffer()
