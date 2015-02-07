#!/bin/bash
# Show help
function show_help {
  echo "Specify existing directory";
}

# Ask user
function ask {
  while true; do
    read -p "$1 [Y/n] " yn
    case $yn in
      [Nn]* ) break;;
      * ) $2; break;;
    esac
  done
}

# Update submodules
function submodule {
  git submodule update --init --recursive
}
# Apply patches
function patch {
  cd $dotfiles
  git am $dotfiles/patches/*.patch
}

# Comple YouCompleteMe
function ycm {
  $dotfiles/vim/bundle/YouCompleteMe/install.sh
}

# Install tmux-vim-select-pane
function tvpane {
  sudo curl -fsSL https://raw.github.com/mislav/dotfiles/1500cd2/bin/tmux-vim-select-pane -o /usr/local/bin/tmux-vim-select-pane
  sudo chmod +x /usr/local/bin/tmux-vim-select-pane
}

# Install fonts
function fonts {
  curl -fsSL https://github.com/Lokaltog/powerline-fonts/raw/master/SourceCodePro/Sauce%20Code%20Powerline%20Regular.otf -o "$HOME/.fonts/Sauce Code Powerline Regular.otf"
}

# Setup symlinks to config files
function symlink {
  if [ ! -f ~/.tmux.conf ]; then ln -s $dotfiles/tmux.conf ~/.tmux.conf; fi
  if [ ! -f ~/.zshrc ]; then ln -s $dotfiles/zshrc ~/.zshrc; fi
  if [ ! -f ~/.vimrc ]; then ln -s $dotfiles/vimrc ~/.vimrc; fi
  if [ ! -f ~/.yaourtrc ]; then ln -s $dotfiles/yaourtrc ~/.yaourtrc; fi
  if [ ! -f ~/.gitignore ]; then ln -s $dotfiles/.gitignore ~/.gitignore; fi
  if [ ! -d ~/.vim ]; then ln -s $dotfiles/vim ~/.vim; fi
  if [ ! -d ~/.local/bin/scripts ]; then ln -s $dotfiles/scripts ~/.local/bin/scripts; fi
  echo "All symlink have been made"
}

dotfiles="$1"
if [ -z "$1" ]; then show_help; exit 0; fi; 
if [ ! -d $1 ]; then show_help; exit 0; fi;

cd $dotfiles

# Ask and execute the install script
ask "Update submodules" submodule
ask "Apply patches" patch
ask "Compile YCM" ycm
ask "Install tmux-vim-select-pane" tvpane
ask "Install fonts" fonts
# ask "Install gnome-terminal theme"
ask "Make symlinks" symlink
