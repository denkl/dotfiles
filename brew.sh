#!/usr/bin/env sh

echo 'start...'

brew update

brew upgrade

brew tap homebrew/cask-fonts

brew install bat
brew install coreutils
brew install dust
brew install fd
brew install fish
brew install fzf
brew install git
brew install git-delta
brew install gnupg
brew install htop
brew install jq
brew install kcat
brew install kubectl
brew install ncdu
brew install neovim
brew install node
brew install pv
brew install pyenv
brew install pyenv-virtualenv
brew install stow
brew install telnet
brew install tldr
brew install tokei
brew install wget
brew install youtube-dl

brew install --cask kitty
brew install --cask font-fira-code
brew install --cask ngrok
brew install --cask karabiner-elements

brew cleanup

echo 'done'
