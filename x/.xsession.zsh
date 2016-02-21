#!/bin/zsh
#
function maybe_source() {
    [[ -r $1 ]] && . $1
}

echo "oh hai" > ~/diditwork

maybe_source ~/.zshenv
maybe_source ~/.zshrc
maybe_source ~/.zlogin

exec i3
