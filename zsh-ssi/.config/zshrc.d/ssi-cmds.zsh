# fpath+=($HOME/src/x/zsh-funcs)

# autoload -Uz "${HOME}/src/x/zsh-funcs"/*

# wtsvcrepo() {
#   DEVOPS_SERVICES="$HOME/src/devops/services"
#   service="$1"
#   if [[ -z "$service" ]]; then
#     echo "usage: $0 SERVICE" >&2
#     return 1
#   fi
#   deployfile="$DEVOPS_SERVICES/$service/prod/deploy.toml"
#   if [[ ! -f "$deployfile" ]]; then
#     echo "service $service not found\n  ($deployfile not found)" >&2
#     return 1
#   fi
#   awk -F '"' '/repo =/ { print $2 }' "$deployfile"
# }

jql() {
  jq -C "$@" | less -FXR
}

with_config() {
  if (( $# < 2 )); then
    echo "Usage: with_config <config> command [args]..."
    return 1
  fi
  new_config=$1
  shift
  old_config=$(readlink config.toml)
  {
    ln -fs "$new_config" config.toml
    "$@"
  } always {
    if [[ ! -z "$old_config" ]]; then
      echo "Restored config $old_config" 2>&1
      ln -fs "$old_config" config.toml
    fi
  }
}

soccer-script() {
  local name="$1"
  scripts_json="${HOME}/src/data/semantics-soccer/soccer/configs/scripts.json"
  jq ".${name}.script_file" < "${scripts_json}"
}

alias kubectl="AWS_PROFILE=eks kubectl"
alias vikingctl="AWS_PROFILE=eks kubectl --context viking"
alias valkyriectl="AWS_PROFILE=ekx kubectl --context valkyrie"
alias knightctl="AWS_PROFILE=ekx kubectl --context knight"

jack-in() {
  local cluster="$1"
  local app="$2"
  local env="$3"

  if [[ -z "$cluster" ]]; then
    cluster="valkyrie"
    app="redstone"
    env="prod"
  fi

  local pod=$(kubectl get pods --context "$cluster" -n "$env" -l "ssi.app == $app" -o name | head -n 1)
  if [[ -z "$pod" ]]; then
    echo "pod not found"
    return 1
  fi

  kubectl exec --context "$cluster" -n "$env" -ti "$pod" -- /bin/bash
}
