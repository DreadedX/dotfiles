#!/bin/bash
set -e

sudo apt-get install fuse libfuse2 unzip ripgrep python3-venv xclip -y --no-install-recommends
sudo rm -rf /usr/local/bin/nvim
sudo wget https://github.com/neovim/neovim-releases/releases/download/v0.11.1/nvim-linux-x86_64.appimage -O /usr/local/bin/nvim
sudo chmod +x /usr/local/bin/nvim

rm -rf ~/.dotfiles
git clone https://git.huizinga.dev/Dreaded_X/dotfiles ~/.dotfiles
mkdir -p ~/.config
ln -s ~/.dotfiles/nvim/dot-config/nvim ~/.config/nvim
