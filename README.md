# dotfiles

## directories of note

* .config/zshenv.d
* .config/zshrc.d

## first time setup

It's a good idea to make these directories first, so that stow doesn't try to make
them as symlinks (which will cause headaches).

```bash
mkdir -p ~/.local/{bin,share} ~/.config
```

or just

```
./init.sh
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

## Ignoring files

A package directory (e.g. `git/`) can specify files to ignore:

```bash
\.gitignore
```

see the [stow manual][stowignore] for more.

[stowignore]: <http://www.gnu.org/software/stow/manual/html_node/Types-And-Syntax-Of-Ignore-Lists.html>

## Brew bundle

[homebrew-bundle README](https://github.com/Homebrew/homebrew-bundle/blob/master/README.md)

```bash
brew bundle
brew bundle dump
```
