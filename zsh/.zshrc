# zmodload zsh/zprof

setopt beep
setopt extendedglob
setopt nomatch

# directories
setopt autocd autopushd pushdignoredups

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

# autoload contents of ~/.zfunc
autoload -U ~/.zfunc/**/*(.:t)


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
pidonport() { lsof -t -i:$1 }
alias pidp=pidonport
alias reload="exec zsh"
alias repry='fc -e - mix\ test=iex\ -S\ mix\ test\ --trace mix\ test'
alias usystemctl="systemctl --user"
alias weechat="weechat -d $XDG_CONFIG_HOME/weechat"
warp() { cd $(readlink "$1") }

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
alias d='dirs -v | head -10'
alias e=nvim # edit
alias f=fzf # find / fuzzy # filter
alias g=rg
alias G=git
alias j=jq
alias j.=jq .

alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

function l() {
  if [[ "$#" == 0 ]]; then
    less
  else
    "$@" | less
  fi
}

with_lnav() {
  with_tty $@ 2>&1 | lnav -q
}

with_lnav_q() {
  with_tty $@ 2>&1 | lnav -q
}

with_x() {
  (set -x; $@)
}

with_tty() {
  local lines=$(tput lines)
  local cols=$(tput cols)
  local cmd=($@)
  with_x socat - SYSTEM:"stty rows $lines cols $cols; ${cmd}",pty,setsid,ctty,stderr
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

if [[ -n "${SHELL_BECOME_EXEC}" ]]; then
  exec ${SHELL_BECOME_EXEC}
fi

if [[ -n "${SHELL_FINALLY}" ]]; then
  ${SHELL_FINALLY}
fi

export PATH="$HOME/.poetry/bin:$PATH"

#
# super duper annoying.  macos zsh seems to prepend system paths to $path after
# sourcing ~/.zshenv. so set a few here again
prepend_path "/opt/homebrew/bin" 
prepend_path "$HOME/.local/bin"

init_pyenv() {
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
}

# init_pyenv

iterm() {
  local sub=$1
  shift
  if [[ "$sub" == "clear" ]]; then
    clear && printf '\e[3J'
    return 0
  else
    echo "unknown subcommand $sub"
    return 1
  fi
}

export PYTHONBREAKPOINT='IPython.core.debugger.set_trace'

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

fix-conda-path() {
  local conda_path=()
  local i=0
  local p=''
  while ((i=$path[(I)*miniconda*])); do
    p=$path[$i]
    conda_path+=("$p")
    path[$i]=()
  done
  for p in $conda_path; do
    path=("$p" "$path[@]")
  done
  echo Moved $conda_path to head of the path
}


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

