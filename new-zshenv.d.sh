#!/bin/bash

pkg="$1"

if [[ -z "${pkg}" ]]; then
  echo "usage: $0 <pkg-name>"
  exit 1
fi

envfile="${pkg}/.config/zshenv.d/${pkg}.zsh"
mkdir -p "$(dirname "$envfile")"
touch "${envfile}"
stow "${pkg}"
"${EDITOR}" "${envfile}"
