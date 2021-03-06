#!/usr/bin/env sh

echo 'start...'

brew update

brew upgrade

brew tap hashicorp/tap
brew tap homebrew/cask-fonts

brew install bat
brew install coreutils
brew install dust
brew install fd
brew install ffmpeg
brew install fish
brew install fisher
brew install fzf
brew install git
brew install git-delta
brew install gnupg
brew install gopls
brew install hashicorp/tap/terraform
brew install hashicorp/tap/terraform-ls
brew install htop
brew install jq
brew install kcat
brew install kubectl
brew install lazydocker
brew install llvm
brew install ncdu
brew install neovim
brew install nghttp2
brew install node
brew install pv
brew install pyenv
brew install pyenv-virtualenv
brew install ripgrep
brew install starship
brew install stow
brew install telnet
brew install tldr
brew install tokei
brew install tree
brew install wget
brew install youtube-dl

brew install --cask font-fira-code
brew install --cask karabiner-elements
brew install --cask kitty
brew install --cask ngrok
brew install --cask insomnia
brew install --cask raycast

brew cleanup

echo 'done'
