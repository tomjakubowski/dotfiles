function() {
  function source_if_exists() {
    [[ -f "$1" ]] && . "$1"
  }
  if (( ${+commands[asdf]} )); then
    source_if_exists "/opt/homebrew/opt/asdf/asdf.sh" ||
      source_if_exists "/usr/local/opt/asdf/asdf.sh" ||
      rc_error "asdf script location not found"
  fi
}
