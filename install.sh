#!/bin/bash
if [ $EUID != 0 ]; then
	sudo "$0" "$@"
	exit $?
fi

ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/zshrc ~/.zshrc
ln -s ~/.dotfiles/oh-my-zsh ~/.oh-my-zsh
ln -s ~/.dotfiles/vimrc ~/.vimrc
ln -s ~/.dotfiles/vim ~/.vim
ln -s ~/.dotfiles/gitignore ~/.gitignore

curl -fsSL https://raw.github.com/mislav/dotfiles/1500cd2/bin/tmux-vim-select-pane -o /usr/local/bin/tmux-vim-select-pane
chmod +x /usr/local/bin/tmux-vim-select-pane
