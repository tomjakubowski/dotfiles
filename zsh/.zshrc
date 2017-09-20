# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory beep extendedglob nomatch
unsetopt autocd notify
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/tom/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# le path

typeset -U path
path=("$HOME/.local/bin"
      "$HOME/bin"
      "$NPM_PACKAGES/bin"
      "$HOME/.rbenv/bin"
      "/usr/local/bin"
      $path[@])

# Sane help
unalias run-help 2>/dev/null || true
autoload run-help

# Aliases
if (( $+commands[gls] )); then
    alias ls='gls -h --color=auto'
else
    alias ls='ls -h --color=auto'
fi
alias irc="abduco -A irc zsh -c 'weechat -d $XDG_CONFIG_HOME/weechat'"
alias weechat="weechat -d $XDG_CONFIG_HOME/weechat"
alias e="emacsclient -c -n"

# Prompt
autoload -U colors && colors
PROMPT="%F{blue}%n@%m%f:%~
%# "

# functions
function beep() { eval $* ; printf "\a" }
function E() {
    local fullpath=$(readlink -f ${@[-1]})
    emacsclient -c -n -e "(find-file \"/sudo::${fullpath}\")"
}
function nmpath() {
    local nmbin="$PWD/node_modules/.bin"
    if [[ -d $nmbin ]];
    then
        path+=($nmbin)
    else
        echo "Couldn't find $nmbin, not adding to path!"
    fi
}

# base16 color shell script
BASE16_SHELL="$HOME/scripts/base16-eighties.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# set path here to work around sadness on arch linux.
path=("$HOME/.local/bin"
      "$HOME/bin"
      "$GOPATH/bin"
      "$NPM_PACKAGES/bin"
      "$HOME/.rbenv/bin"
      "/usr/local/bin"
      $path[@])
typeset -U path

if [[ -d "$XDG_CONFIG_HOME/zshrc.d" ]]; then
    for file in $XDG_CONFIG_HOME/zshrc.d/*.{zsh,sh}(N); do
        source $file
    done
fi
