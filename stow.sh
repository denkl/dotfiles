#!/usr/bin/env sh
STOW_FOLDERS="fish,git,gnupg,isort,karabiner,kitty,nvim,ripgrep,vim,ipython"

for folder in $(echo $STOW_FOLDERS | sed "s/,/ /g")
do
    stow $folder
done
