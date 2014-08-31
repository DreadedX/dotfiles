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

#install gnome-terminal-colors-solarized
while true; do
    read -p "Do you wish to install gnome-terminal-colors-solarized? " yn
    case $yn in
        [Yy]* ) sudo apt-get install dconf-cli;
		git clone https://github.com/Anthony25/gnome-terminal-colors-solarized.git
		cd gnome-terminal-colors-solarized;
		./install.sh;
		cd ..;
		rm -rf gnome-terminal-colors-solarized;
		break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

if [ ! -f /usr/local/bin/tmux-vim-select-pane ]; then
	curl -fsSL https://raw.github.com/mislav/dotfiles/1500cd2/bin/tmux-vim-select-pane -o /usr/local/bin/tmux-vim-select-pane;
	chmod +x /usr/local/bin/tmux-vim-select-pane;
fi

echo "Done installing..."
