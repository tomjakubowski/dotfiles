if !exists("b:ale_linters")
  let b:ale_linters = ['mypy', 'flake8']
endif
if !exists("b:ale_fixers")
  let b:ale_fixers = ['yapf', 'black']
endif
