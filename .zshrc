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

# Sane help
unalias run-help
autoload run-help

# Aliases
alias ls='ls -h --color=auto'
alias weechat="weechat -d $XDG_CONFIG_HOME/weechat"

# Prompt
autoload -U colors && colors
PROMPT="%F{blue}%n@%m%f:%~
%# "
