call ale#linter#Define('json', {
      \ 'name': 'thergonauts',
      \ 'lsp': 'thergonauts',
      \ 'executable': {b -> ale#Var(b, 'json_thergonauts_executable')}
      \ 'command': '%e'
      \})
