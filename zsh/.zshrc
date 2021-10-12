if [ -z "$TMUX" ]; then tmux; exit; fi

export ZDOTDIR="${HOME}/.dotfiles/zsh"
export EDITOR=nvim
export USE_CCACHE=1
export DOCKER_CLIENT_TIMEOUT=300
export COMPOSE_HTTP_TIMEOUT=300

export PATH="${HOME}/.local/bin:$PATH"

alias cl="clear"
alias tmux="tmux -2"

KEYTIMEOUT=1

# Source Prezto.
if [[ -s "${ZDOTDIR}/prezto/init.zsh" ]]; then
  source "${ZDOTDIR}/prezto/init.zsh"
fi

if [[ -s "${ZDOTDIR}/gitalias.zsh" ]]; then
  source "${ZDOTDIR}/gitalias.zsh"
fi

export GREP_COLORS="mt=01;32"
