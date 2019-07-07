" rust
let b:ale_linters = ['rls']
let b:ale_rust_cargo_check_tests = 1
let b:ale_rust_cargo_check_examples = 1
let b:rustfmt_autosave = 1

setl tags=./rusty-tags.vi;

augroup tomrust
  au!
  au BufWritePost <buffer> :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "@" | redraw!
augroup END
