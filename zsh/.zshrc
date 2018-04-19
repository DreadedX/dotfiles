#oh-my-zsh
ZSH=~/.dotfiles/oh-my-zsh
ZSH_THEME="agnoster"
# plugins=(sudo colored-man git gitignore gitfast)
plugins=(sudo colored-man git gitignore)
setopt correct
source $ZSH/oh-my-zsh.sh

#setting environment variables
export EDITOR=nvim
export ABSROOT=$HOME/Projects/abs
export PATH="/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/bin/scripts:$PATH:/usr/bin/core_perl"
export TERM="screen-256color"
export SAL_USE_VCLPLUGIN="gtk"
export GOPATH="$HOME/.local/go"
export PATH="$HOME/.local/go/bin:$PATH"
export USE_CCACHE=1

#setting aliases
alias cl="clear"
alias mtgames.nl="gnome-terminal -x ssh server@188.166.73.149 -t tmux a"
alias vim="nvim"
alias tmux="tmux -2"
alias attach="tmux a"
alias wcp="wc -l **/src/**/*.cpp **/include/**/*.h"

#start tmux
if [ -z "$TMUX" ]; then tmux; exit; fi

export FZF_DEFAULT_OPTS='--height 20%'
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
