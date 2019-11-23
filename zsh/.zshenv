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

typeset -U path
path=("$HOME/.local/bin"
      "/usr/local/bin"
      $path[@])

# vim is slightly more likely to work than emacsclient
export EDITOR="vim"
if (( ${+commands[nvim]} )); then
  export EDITOR="nvim"
fi
export SUDO_EDITOR="$EDITOR"

export MPV_HOME="$XDG_CONFIG_HOME/mpv"

# TODO: Move some of these into .config/zshenv.d directory

export CARGO_INSTALL_ROOT="$HOME/.local"
export ABDUCO_SOCKET_DIR="$XDG_RUNTIME_DIR"

export GOPATH="$HOME/gocode"

if [[ -z "$TOM_HOST" ]]; then
  export TOM_HOST=$(hostname)
fi
if [[ -z "$TOM_UNAME" ]]; then
  export TOM_UNAME=$(uname)
fi

[[ -f "$HOME/.zshenv_local" ]] && source "$HOME/.zshenv_local"
if [[ -d "$XDG_CONFIG_HOME/zshenv.d" ]]; then
  setopt nullglob
  for file in $XDG_CONFIG_HOME/zshenv.d/*.zsh; do
    source "$file"
  done
  unsetopt nullglob
fi

# fuck it :(
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
[[ -f "$HOME/.poetry/env" ]] && source "$HOME/.poetry/env"

if (( ${+commands[sccache]} )); then
  export RUSTC_WRAPPER=${commands[sccache]}
fi
