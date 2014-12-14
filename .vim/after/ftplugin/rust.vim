compiler cargo
setl textwidth=89

nmap <buffer> <F5> = :Make build<CR>
nmap <buffer> <localleader>b = :Make build<CR>
nmap <buffer> <localleader>t = :make test<CR>
