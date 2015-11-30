#oh-my-zsh
ZSH=~/.dotfiles/oh-my-zsh
ZSH_THEME="agnoster"
# plugins=(sudo colored-man git gitignore gitfast)
plugins=(sudo colored-man git gitignore)
setopt correct
source $ZSH/oh-my-zsh.sh

#setting environment variables
export EDITOR=vim
export ABSROOT=$HOME/Projects/abs
export PATH="/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/bin/scripts:$PATH"
export TERM="screen-256color"
export SAL_USE_VCLPLUGIN="gtk"
export GOPATH="$HOME/.local/go"
export PATH="$HOME/.local/go/bin:$PATH"

#setting aliases
alias cl="clear"
alias vim="nvim"
alias tmux="tmux -2"
alias attach="tmux a"
alias wcp="wc -l src/**/*.cpp include/**/*.h"

#start tmux
if [ -z "$TMUX" ]; then tmux; exit; fi
