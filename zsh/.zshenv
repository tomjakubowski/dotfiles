if [[ -z "$XDG_CONFIG_HOME" ]]; then
    export XDG_CONFIG_HOME="$HOME/.config"
fi
if [[ -z "$XDG_RUNTIME_DIR" ]]; then
    export XDG_RUNTIME_DIR="$HOME/.run"
    if ! [ -d "$XDG_RUNTIME_DIR" ]; then
        mkdir -p "$XDG_RUNTIME_DIR"
    fi
    chmod 700 "XDG_RUNTIME_DIR"
fi

export MPV_HOME="$XDG_CONFIG_HOME/mpv"
export NPM_PACKAGES="$HOME/.npm-packages"

export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
export CARGO_INSTALL_ROOT="$HOME/.local"
export ABDUCO_SOCKET_DIR="$XDG_RUNTIME_DIR"

typeset -U path
path=("$HOME/.local/bin"
      "$HOME/bin"
      "$NPM_PACKAGES/bin"
      "$HOME/.rbenv/bin"
      "/usr/local/bin"
      $path[@])

[[ -f $HOME/.zshenv_local ]] && source $HOME/.zshenv_local
