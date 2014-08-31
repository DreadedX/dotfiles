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
    read -p "Do you wish to install gnome-terminal-colors-solarized? " yn1
    case $yn1 in
        [Yy]* ) sudo apt-get install dconf-cli;
		git clone https://github.com/Anthony25/gnome-terminal-colors-solarized.git
		cd gnome-terminal-colors-solarized;
		./install.sh;
		cd ..;
		rm -rf gnome-terminal-colors-solarized;
		break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

while true; do
    read -p "Do you wish to update all submodules? " yn2
    case $yn2 in
        [Yy]* ) git submodule update --init --recursive
		break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

while true; do
    read -p "Do you wish to compile YCM? " yn3
    case $yn3 in
        [Yy]* ) ./vim/bundle/YouCompleteMe/install.sh
		break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

git submodule update --init --recursive


if [ ! -f /usr/local/bin/tmux-vim-select-pane ]; then
	curl -fsSL https://raw.github.com/mislav/dotfiles/1500cd2/bin/tmux-vim-select-pane -o /usr/local/bin/tmux-vim-select-pane;
	chmod +x /usr/local/bin/tmux-vim-select-pane;
fi

echo "Done installing..."
