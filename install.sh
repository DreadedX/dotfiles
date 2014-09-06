#!/bin/bash
# TODO: Add eclim/eclipse installer
while true; do
	read -p "Do you want to make symlinks? " yn
	case $yn in
	    [Yy]* ) if [ ! -f ~/.tmux.conf ]; then ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf; fi
		    if [ ! -f ~/.zshrc ]; then ln -s ~/.dotfiles/zshrc ~/.zshrc; fi
		    if [ ! -f ~/.vimrc ]; then ln -s ~/.dotfiles/vimrc ~/.vimrc; fi
		    if [ ! -d ~/.vim ]; then ln -s ~/.dotfiles/vim ~/.vim; fi
		    if [ ! -f ~/.gitignore ]; then ln -s ~/.dotfiles/gitignore ~/.gitignore; fi
		    echo "Done...";
		    break;;
	    [Nn]* ) break;;
    	    * ) echo "Please answer yes or no.";;
	esac
done

while true; do
	read -p "Do you wish to install gnome-terminal-colors-solarized? (requires dconf-cli) " yn
    case $yn in
        [Yy]* ) cd ..; 
		git clone https://github.com/Anthony25/gnome-terminal-colors-solarized.git;
		cd gnome-terminal-colors-solarized;
		./install.sh;
		cd ..;
		rm -rf gnome-terminal-colors-solarized;
		cd .dotfiles;
		echo "Done...";
		break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

while true; do
    read -p "Do you wish to update all submodules? " yn
    case $yn in
        [Yy]* ) git submodule update --init --recursive;
		echo "Done...";
		break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

while true; do
    read -p "Do you wish to compile YCM? " yn
    case $yn in
        [Yy]* ) ./vim/bundle/YouCompleteMe/install.sh;
		echo "Done...";
		break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

while true; do
    read -p "Do you wish to install powerline? " yn
    case $yn in
        [Yy]* ) pip install --user git+git://github.com/Lokaltog/powerline;
		cd ..
	        wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf;
		mkdir -p ~/.fonts/ && mv PowerlineSymbols.otf ~/.fonts/;
		fc-cache -vf ~/.fonts;
		mkdir -p ~/.config/fontconfig/conf.d/ && mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/;
		cd .dotfiles
		echo "Done...";
		break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

while true; do
    read -p "Do you wish to install tmux-vim-select-pane? " yn
    case $yn in
        [Yy]* )	sudo curl -fsSL https://raw.github.com/mislav/dotfiles/1500cd2/bin/tmux-vim-select-pane -o /usr/local/bin/tmux-vim-select-pane;
		sudo chmod +x /usr/local/bin/tmux-vim-select-pane;
		echo "Done...";
		break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

while true; do
    read -p "Do you wish to install CTags? " yn
    case $yn in
        [Yy]* )	sudo apt-get install exuberant-ctags;
		echo "Done...";
		break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo "Done installing...";
