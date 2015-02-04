ZSH=~/.dotfiles/oh-my-zsh
ZSH_THEME="../../agnoster"
plugins=(sudo colored-man)

setopt correct
export EDITOR=vim
export TERM="screen-256color"
export ABSROOT=$HOME/Projects/abs

source $ZSH/oh-my-zsh.sh

export PATH="/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games"
export PATH="$HOME/.scripts:$PATH"
if [ -d "$HOME/.local/bin" ]; then
	PATH="$HOME/.local/bin:$PATH"
fi

alias rmdep="sudo pacman -Rns $(pacman -Qqtd)"
alias tmux="tmux -2"
alias attach="tmux a"
if [ -z "$TMUX" ]; then tmux; exit; fi

DISABLE_AUTO_TITLE=true
