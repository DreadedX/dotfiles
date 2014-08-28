#!/bin/bash
if [ $EUID != 0 ]; then
	sudo "$0" "$@"
	exit $?
fi

if [ ! -f ~/.tmux.conf ]; then ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf; fi
if [ ! -f ~/.zshrc ]; then ln -s ~/.dotfiles/zshrc ~/.zshrc; fi
if [ ! -f ~/.vimrc ]; then ln -s ~/.dotfiles/vimrc ~/.vimrc; fi
if [ ! -d ~/.vim ]; then ln -s ~/.dotfiles/vim ~/.vim; fi
if [ ! -f ~/.gitignore ]; then ln -s ~/.dotfiles/gitignore ~/.gitignore; fi

#ln -s ~/.dotfiles/zshrc ~/.zshrc
#ln -s ~/.dotfiles/vimrc ~/.vimrc
#ln -s ~/.dotfiles/vim ~/.vim
#ln -s ~/.dotfiles/gitignore ~/.gitignore

if [ ! -f /usr/local/bin/tmux-vim-select-pane ]; then
	curl -fsSL https://raw.github.com/mislav/dotfiles/1500cd2/bin/tmux-vim-select-pane -o /usr/local/bin/tmux-vim-select-pane;
	chmod +x /usr/local/bin/tmux-vim-select-pane;
fi

echo "Done installing..."
