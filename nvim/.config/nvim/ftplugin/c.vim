let b:ale_linters = ['ccls']
let b:ale_fixers = ['clang-format']
let b:tom_clangformat_file = expand(findfile(".clang-format", ".;"))
if len(b:tom_clangformat_file)
  let b:ale_c_clangformat_options = '-style=file'
endif
