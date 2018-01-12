#!/bin/zsh

set -e

function maybe_source() {
    [[ -r $1 ]] && . $1
}

maybe_source ~/.zshenv
maybe_source ~/.zshrc
maybe_source ~/.zlogin

command hsetroot 2>/dev/null && hsetroot -solid '#F5F5DC' -center "$HOME/.local/share/wallpaper"
if [[ "$HOST" == "tjakubowski-sc" ]]; then
    setxkbmap -model pc105 -layout us,us -option ctrl:nocaps
fi
exec i3
