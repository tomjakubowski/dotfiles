# Defined in - @ line 1
function irc --wraps=abduco\ -A\ irc\ zsh\ -c\ \'weechat\ -d\ /home/tom/.config/weechat\' --description alias\ irc=abduco\ -A\ irc\ zsh\ -c\ \'weechat\ -d\ /home/tom/.config/weechat\'
  abduco -A irc zsh -c 'weechat -d /home/tom/.config/weechat' $argv;
end
