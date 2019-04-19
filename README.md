# dotfiles

## first time setup

It's a good idea to make these directories first, so that stow doesn't try to make
them as symlinks (which will cause headaches).

```bash
mkdir -p ~/.local/{bin,share} ~/.config
```

## usage

packages are stored in directories (e.g. `zsh` and `i3`).  to install to the
parent directory of this repo:

```bash
cd ~/dotfiles
stow PACKAGE ...
```

to install to another directory:

```bash
cd ~/dotfiles
stow -t DESTINATION PACKAGE ...
```

to "unstow":

```bash
stow -D PACKAGE ...
```
