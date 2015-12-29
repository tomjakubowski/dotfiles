XDG_CONFIG_HOME='~/.config'
MPV_HOME="$XDG_CONFIG_HOME/mpv"
NPM_PACKAGES="$HOME/.npm-packages"

NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"

[[ -f $HOME/.zshenv_local ]] && source $HOME/.zshenv_local
