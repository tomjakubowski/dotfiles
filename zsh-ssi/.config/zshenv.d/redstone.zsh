path=(
  ~/.mix/escripts
  ~/OTP/24.3.4.3/bin
  # /opt/homebrew/opt/erlang@23/bin
  # ~/elixir/v1.12.3/bin
  # ~/elixir/v1.12.3/bin
  ~/elixir/v1.13.4/bin
  ~/nodejs/node-v16.15.0-darwin-arm64/bin
  /Library/Frameworks/Python.framework/Versions/3.9/bin/
  ${path[@]}
)

switch_elixir1.11() {
  path=(~/elixir/v1.11.4/bin ${path[@]})
}
