#!/bin/bash
set -e

# Install additional dependencies
sudo apt-get install fuse libfuse2 unzip ripgrep python3-venv xclip -y --no-install-recommends

# Install new version of neovim
sudo rm -rf /usr/local/bin/nvim
sudo wget https://github.com/neovim/neovim-releases/releases/download/v0.11.1/nvim-linux-x86_64.appimage -O /usr/local/bin/nvim
sudo chmod +x /usr/local/bin/nvim

# Get latest version of dotfiles
rm -rf ~/.dotfiles
git clone https://git.huizinga.dev/Dreaded_X/dotfiles ~/.dotfiles
mkdir -p ~/.config
ln -s ~/.dotfiles/nvim/dot-config/nvim ~/.config/nvim

# Remove include paths from copied host gitconfig
sed -i '/path = /d' ~/.gitconfig
