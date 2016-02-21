umask 077
eval $(keychain --eval --agents gpg,ssh --clear --quiet --timeout 10)

systemctl --user import-environment
