if [[ -z "$XDG_CONFIG_HOME" ]]; then
    export XDG_CONFIG_HOME="$HOME/.config"
fi
export MPV_HOME="$XDG_CONFIG_HOME/mpv"
export NPM_PACKAGES="$HOME/.npm-packages"

export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
export CARGO_INSTALL_ROOT="$HOME/.local"

[[ -f $HOME/.zshenv_local ]] && source $HOME/.zshenv_local
