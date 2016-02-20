umask 077
eval $(keychain --eval --agents gpg,ssh --clear --quiet --timeout 10)
