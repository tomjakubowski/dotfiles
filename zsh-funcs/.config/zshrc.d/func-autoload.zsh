fpath=( ~/.local/share/zsh/my-functions "${fpath[@]}" )

my_funcs=(
    hello
    sendti
    sc-copy
    sc-paste
)

for func in "${my_funcs[@]}"; do
    autoload -Uz "$func"
done
