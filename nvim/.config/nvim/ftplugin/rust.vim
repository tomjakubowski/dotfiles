" rust
let b:ale_linters = ['rls']
let b:ale_fixers = ['rustfmt']
let b:ale_rust_cargo_check_tests = 1
let b:ale_rust_cargo_check_examples = 1
let b:rustfmt_autosave = 0 " handled by ale fixer
