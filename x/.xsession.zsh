#!/bin/zsh
#
function maybe_source() {
    [[ -r $1 ]] && . $1
}

echo "oh hai" > ~/diditwork

maybe_source ~/.zshenv
maybe_source ~/.zshrc
maybe_source ~/.zlogin

command hsetroot && hsetroot -solid '#F5F5DC' -center "$HOME/.local/share/wallpaper"
exec i3
