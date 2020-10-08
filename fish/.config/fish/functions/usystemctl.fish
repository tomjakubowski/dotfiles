# Defined in - @ line 1
function usystemctl --wraps='systemctl --user' --description 'alias usystemctl=systemctl --user'
  systemctl --user $argv;
end
