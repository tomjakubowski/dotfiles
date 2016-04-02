if [[ -z "$XDG_CONFIG_HOME" ]]; then
    export XDG_CONFIG_HOME="$HOME/.config"
fi
if [[ -z "$XDG_RUNTIME_DIR" ]]; then
    export XDG_RUNTIME_DIR="$HOME/.run"
    if ! [ -d "$XDG_RUNTIME_DIR" ]; then
        mkdir -p "$XDG_RUNTIME_DIR"
    fi
    chmod 700 "$XDG_RUNTIME_DIR"
fi

# vim is slightly more likely to work than emacsclient
export EDITOR="vim"
export SUDO_EDITOR="vim"

export MPV_HOME="$XDG_CONFIG_HOME/mpv"

# TODO: I could have a '.zshenv.d' directory that the various stow
# packages install things like this into.
export npm_config_userconfig="$XDG_CONFIG_HOME/npmrc"
export npm_config_prefix="$HOME/.local/"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"

export CARGO_INSTALL_ROOT="$HOME/.local"
export ABDUCO_SOCKET_DIR="$XDG_RUNTIME_DIR"

export GOPATH="$HOME/gocode"

[[ -f $HOME/.zshenv_local ]] && source $HOME/.zshenv_local
