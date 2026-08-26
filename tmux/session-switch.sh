#!/bin/sh
# Switch to Nth tmux session (1-based) in creation order,
# matching the choose-tree (prefix+s) listing order.
n="$1"
id="$(tmux list-sessions -F '#{session_id}' | cut -c2- | sort -n | sed -n "${n}p")"
[ -z "$id" ] && exit 0
tmux switch-client -t "\$$id"
