#oh-my-zsh
ZSH=~/.dotfiles/oh-my-zsh
ZSH_THEME="../../agnoster"
plugins=(sudo colored-man)
setopt correct
source $ZSH/oh-my-zsh.sh

#setting environment variables
export EDITOR=vim
export ABSROOT=$HOME/Projects/abs
export PATH="/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games"
export PATH="$HOME/.local/bin:$PATH"

#setting aliases
alias rmdep="sudo pacman -Rns $(pacman -Qqtd)"
alias tmux="tmux -2"
alias attach="tmux a"

#start tmux
if [ -z "$TMUX" ]; then tmux; exit; fi
