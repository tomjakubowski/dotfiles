init_chruby() {
  setopt local_options nonomatch
  RUBIES+=($HOME/opt/rubies/*)

  # Homebrew

  if [[ -f /usr/local/share/chruby/chruby.sh ]]; then
    source /usr/local/share/chruby/chruby.sh
  fi
}

init_chruby
