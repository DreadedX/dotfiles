#oh-my-zsh
ZSH=~/.dotfiles/oh-my-zsh
ZSH_THEME="agnoster"
plugins=(sudo colored-man git gitignore gitfast)
setopt correct
source $ZSH/oh-my-zsh.sh

#setting environment variables
export EDITOR=vim
export PATH="/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/bin/scripts:$PATH"
# export TERM="screen-256color"

#setting aliases
alias cl="clear"