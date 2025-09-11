#!/usr/bin/env bash

if ! systemctl is-active --quiet docker; then
	echo "Starting docker..."
	systemctl start docker
fi

devcontainer up --workspace-folder .

tmux rename-window nvim
tmux new-window -n "ros" "devcontainer exec --workspace-folder . bash"
tmux new-window -n "shell"
tmux select-window -t :-2

devcontainer exec --workspace-folder . nvim
