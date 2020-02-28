setopt beep
setopt extendedglob
setopt nomatch

bindkey -e

fpath+=~/.local/share/zsh/site-functions

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
alias irc="abduco -A irc zsh -c 'weechat -d $XDG_CONFIG_HOME/weechat'"
alias weechat="weechat -d $XDG_CONFIG_HOME/weechat"
alias e="emacsclient -c -n"
alias usystemctl="systemctl --user"

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
  function ls() {
    local dotfiles_home=$HOME/dotfiles
    local lsflags=("-h" "--color=auto")
    # If we wanted to match the dotfiles dir itself, the LHS would be "$PWD/"
    # But it turns out we only really want the dotfiles one level down from
    # that in the dotfiles dir tree anyway.
    if [[ "$PWD" = "$dotfiles_home"/* ]]; then
      lsflags+=("-A")
    fi
    command "gls" "${lsflags[@]}" "$@"
  }
elif [[ "$(ls --version)" != "*coreutils*" ]]; then
  function ls() {
    local dotfiles_home=$HOME/dotfiles
    local lsflags=("-h" "--color=auto")
    # If we wanted to match the dotfiles dir itself, the LHS would be "$PWD/"
    # But it turns out we only really want the dotfiles one level down from
    # that in the dotfiles dir tree anyway.
    if [[ "$PWD" = "$dotfiles_home"/* ]]; then
      lsflags+=("-A")
    fi
    command ls "${lsflags[@]}" "$@"
  }
fi

if (( ${+commands[dircolors]} )); then
  eval $(dircolors ~/.local/share/dircolors/solarized-ansi-universal)
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

autoload -U select-word-style
select-word-style bash

# Prompt

icon=''
if [[ -f ~/.config/icon ]];
then
  icon=" $(cat ~/.config/icon)"
fi

if [[ ${+commands[starship]} ]]
then
  export STARSHIP_HOST_ICON="${icon}"
  eval "$(starship init zsh)"
else
  # Fallback prompt
  autoload -U colors && colors
  PROMPT="%F{green}%n@%m${icon}%f:%~
%# "

fi

case ${TERM} in
  xterm*)
    precmd () {
      print -Pn "\e]0;%n@%m$icon: %~\a"
    }
    ;;
esac

[[ -s ~/.fzf.zsh ]] && source ~/.fzf.zsh
[[ -s ~/.nvm/nvm.sh ]] && source ~/.nvm/nvm.sh
