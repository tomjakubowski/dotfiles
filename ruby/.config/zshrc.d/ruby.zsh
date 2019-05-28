init_chruby() {
  setopt local_options nonomatch
  # Homebrew location:
  if [[ -f /usr/local/share/chruby/chruby.sh ]]; then
    source /usr/local/share/chruby/chruby.sh
  else
    echo "ruby dotfiles: can't find chruby to source"
    return 1
  fi
  RUBIES+=($HOME/opt/rubies/*)
}

init_chruby
