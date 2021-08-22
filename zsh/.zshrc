# zmodload zsh/zprof

setopt beep
setopt extendedglob
setopt nomatch

bindkey -e

fpath+=~/.local/share/zsh/site-functions
if type brew &>/dev/null; then
  fpath+=$(brew --prefix)/share/zsh/site-functions
fi

# History options
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt appendhistory
setopt extended_history
setopt hist_ignore_space
setopt hist_lex_words
setopt hist_verify
setopt inc_append_history_time

# The following lines were added by compinstall
zstyle :compinstall filename '/home/tom/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Sane help
unalias run-help 2>/dev/null || true
autoload run-help

# Aliases
alias abduco="abduco -e '^q'"
alias ec="emacsclient -c -n"
alias irc="abduco -A irc zsh -c 'weechat -d $XDG_CONFIG_HOME/weechat'"
alias nv="nvim"
alias reload="exec zsh"
alias usystemctl="systemctl --user"
alias weechat="weechat -d $XDG_CONFIG_HOME/weechat"

# Alphavit
alias e=nvim # edit
alias f=fzf # find / fuzzy # filter
alias g=rg
alias G=git

function l() {
  if [[ "$#" == 0 ]]; then
    less
  else
    "$@" | less
  fi
}

# Prompt
autoload -U colors && colors
icon=''
if [[ -f ~/.config/icon ]];
then
  icon=" $(cat ~/.config/icon)"
fi
PROMPT="%F{green}%n@%m${icon}%f:%~
%# "

set_xterm_title() {
  print -Pn "\e]%n@%m: %~\a"
}
case ${TERM} in
  xterm*)
    precmd_functions+=(set_xterm_title)
    ;;
esac

# functions
function beep() { eval $* ; printf "\a"; }
function nmpath() {
  local nmbin="$PWD/node_modules/.bin"
  if [[ -d $nmbin ]];
  then
    path+=("$nmbin")
  else
    echo "Couldn't find $nmbin, not adding to path!"
  fi
}

if (( ${+commands[gls]} )); then
  lscmd="gls"
  is_gnu_ls="1"
else
  lscmd="ls"
fi

function ls() {
  local dotfiles_home=$HOME/dotfiles
  local lsflags=("-h")
  if [[ -v is_gnu_ls ]]; then
    lsflags+=("--color=auto")
  fi
  # If we wanted to match the dotfiles dir itself, the LHS would be "$PWD/"
  # But it turns out we only really want the dotfiles one level down from
  # that in the dotfiles dir tree anyway.
  if [[ "$PWD" = "$dotfiles_home"/* ]]; then
    lsflags+=("-A")
  fi
  command "$lscmd" "${lsflags[@]}" "$@"
}

jql() {
  jq -C "$@" | less -r
}

if (( ${+commands[dircolors]} )); then
  eval $(dircolors ~/.local/share/dircolors/nord)
fi

if [[ -d "$XDG_CONFIG_HOME/zshrc.d" ]]; then
  setopt nullglob
  for file in ${XDG_CONFIG_HOME}/zshrc.d/*.{zsh,sh}; do
    source ${file}
  done
  unsetopt nullglob
fi


scratch() {
  cd $(mktemp -d)
}

line() {
  if [[ "$#" < 2 ]]; then
    echo "usage: $0 <num> <file...>"
    return 1
  fi
  num=$1
  shift
  sed -ne "${num}p" "$@"
}

install_python_devtools() {
  python -m pip install -U \
    msgpack \
    pip \
    pynvim \
    python-language-server
}

relog() {
  exec zsh -l
}

tcargo() {
  local crateroot
  scratch
  cargo init --name "tcargo" "$@"
  [[ -f "src/main.rs" ]] && crateroot="src/main.rs"
  [[ -f "src/lib.rs" ]] && crateroot="src/lib.rs"
  nvim "$crateroot"
}

qplot() {
  gnuplot -p -e "plot '-'"
}

autoload -U select-word-style
select-word-style bash

# Prompt

icon=''
if [[ -f ~/.config/icon ]];
then
  icon="$(cat ~/.config/icon)"
fi

# if (( false && ${+commands[starship]} ))
# then
#   export STARSHIP_HOST_ICON="${icon}"
#   eval "$(starship init zsh)"
# fi
autoload -U colors && colors
PROMPT="%F{green}%m${icon}%f:%2~ %# "

[[ -s ~/.fzf.zsh ]] && source ~/.fzf.zsh
[[ "$TOM_IN_VSCODE" = "1" && -e ~/.nvm/nvm.sh ]] && source ~/.nvm/nvm.sh
test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"

# zprof

if [[ -n "${SHELL_BECOME_EXEC}" ]]; then
  exec ${SHELL_BECOME_EXEC}
fi

if [[ -n "${SHELL_FINALLY}" ]]; then
  ${SHELL_FINALLY}
fi
