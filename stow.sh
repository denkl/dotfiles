#!/usr/bin/env bash
STOW_FOLDERS="fish,git,gnupg,isort,karabiner,kitty,nvim,ripgrep,vim"

for folder in $(echo $STOW_FOLDERS | sed "s/,/ /g")
do
    stow $folder
done
