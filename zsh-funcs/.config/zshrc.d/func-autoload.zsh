fpath=( ~/.local/share/zsh/my-functions "${fpath[@]}" )

my_funcs=(
    hello
    sendti
)

for func in "${my_funcs[@]}"; do
    autoload -Uz "$func"
done
