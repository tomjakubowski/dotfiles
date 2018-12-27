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
if [[ -z "$XDG_CACHE_HOME" ]]; then
    export XDG_CACHE_HOME="$HOME/.cache"
fi


# vim is slightly more likely to work than emacsclient
export EDITOR="vim"
export SUDO_EDITOR="vim"

export MPV_HOME="$XDG_CONFIG_HOME/mpv"

# TODO: Move some of these into .config/zshenv.d directory

export CARGO_INSTALL_ROOT="$HOME/.local"
export ABDUCO_SOCKET_DIR="$XDG_RUNTIME_DIR"

export GOPATH="$HOME/gocode"

[[ -f "$HOME/.zshenv_local" ]] && source "$HOME/.zshenv_local"
if [[ -d "$XDG_CONFIG_HOME/zshenv.d" ]]; then
    for file in $XDG_CONFIG_HOME/zshenv.d/*.zsh(N); do
        source "$file"
    done
fi

# fuck it :(
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
