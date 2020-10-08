if type --quiet "gnome-session-inhibit"
  # Defined in - @ line 1
  function mpv --wraps='gnome-session-inhibit mpv' --description 'alias mpv gnome-session-inhibit mpv'
    gnome-session-inhibit mpv $argv;
  end
end
