# dotfiles

## usage

packages are stored in directories (e.g. `zsh` and `i3`).  to install to the
parent directory of this repo:

``` bash
cd ~/dotfiles
stow PACKAGE ...
```

to install to another directory:

``` bash
cd ~/dotfiles
stow -t DESTINATION PACKAGE ...
```
