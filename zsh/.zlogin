umask 022

(( $+commands[keychain] )) && eval $(keychain --eval --agents gpg,ssh \
                                              --quiet --timeout 10)

(( $+commands[systemctl] )) && systemctl --user import-environment

true
