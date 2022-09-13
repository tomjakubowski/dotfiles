# zmodload zsh/zprof

setopt beep
setopt extendedglob
setopt nomatch

bindkey -e

if type brew &>/dev/null; then
  fpath=(
    "$(brew --prefix)/share/zsh/site-functions"
    "${fpath[@]}"
  )
fi
fpath=(
  ~/.zfunc
  ~/.local/share/zsh/site-functions
  "${fpath[@]}"
  )

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

# safety first
alias mv="mv -i"

# Magically quote URLs when typing/pasting

autoload -U url-quote-magic bracketed-paste-magic
zstyle :urlglobber url-other-schema http https ftp s3
zle -N self-insert url-quote-magic
zle -N bracketed-paste bracketed-paste-magic

# keybindings
bindkey -s '5~' 'reload\n'

# Alphavit
alias e=nvim # edit
alias f=fzf # find / fuzzy # filter
alias g=rg
alias G=git
alias j=jq
alias j.=jq .

function l() {
  if [[ "$#" == 0 ]]; then
    less
  else
    "$@" | less
  fi
}

# Prompt

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
function append_node_modules_path() {
  local nmbin="$PWD/node_modules/.bin"
  if [[ -d $nmbin ]];
  then
    path+=("$nmbin")
  else
    echo "Couldn't find $nmbin, not adding to path!"
  fi
}
function prepend_path() {
  [[ -z "$1" ]]  && { echo "provide path"; return 1; }
  print -v abspath -r -- "$1:P"
  path=("$abspath" "$path[@]")
}

function rc_error() {
  local script="${funcfiletrace[1]}"
  echo "$script $*"
}

if (( ${+commands[gls]} )); then
  lscmd="gls"
  is_gnu_ls="1"
else
  lscmd="ls"
  if ls --version 2>/dev/null | grep 'GNU coreutils'>/dev/null; then
    is_gnu_ls="1"
  fi
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

dircolors_theme="$HOME/.local/share/dircolors/nord"

if (( ${+commands[dircolors]} )); then
  eval $(dircolors "$dircolors_theme")
elif (( ${+commands[gdircolors]} )); then
  eval $(gdircolors "$dircolors_theme")
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
function() {
  setopt prompt_subst
  autoload -U colors && colors

  local succ='%(?.%#.%F{red}%B%#%f%b)'
  local host
  local bg_jobs='%(1j.[%j].)'
  if [[ -n "$SSH_CLIENT" ]]; then
    host="%F{green}%m%f:"
  else
    host=""
  fi
  PROMPT="${host}%F{blue}%B%2~%f%b ${bg_jobs}${succ} "

  GIT_PS1_SHOWDIRTYSTATE=1
  # $'foo' is called "POSIX quotes"
  if typeset -f __git_ps1 >/dev/null; then
    RPROMPT=$'%F{yellow}$(__git_ps1 "(%s)")%f'
  else
    echo "warning: __git_ps1 not found, not setting RPROMPT"
  fi
}

[[ -s ~/.fzf.zsh ]] && source ~/.fzf.zsh
# [[ "$TOM_IN_VSCODE" = "1" && -e ~/.nvm/nvm.sh ]] && source ~/.nvm/nvm.sh
# test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"

# zprof

if [[ -n "${SHELL_BECOME_EXEC}" ]]; then
  exec ${SHELL_BECOME_EXEC}
fi

if [[ -n "${SHELL_FINALLY}" ]]; then
  ${SHELL_FINALLY}
fi

export PATH="$HOME/.poetry/bin:$PATH"
