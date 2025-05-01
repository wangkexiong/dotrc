#!/bin/sh

new=""

if (( $(echo "$(tmux -V | cut -d' ' -f2 | tr -cd '[:digit:].') < 2.1" | bc -l) )); then
  old=$(tmux show -gv mouse-resize-pane)

  if [ "$old" = "on" ]; then
    new="off"
  else
    new="on"
  fi

  tmux set -g mode-mouse $new >/dev/null
  tmux set -g mouse-resize-pane $new >/dev/null
  tmux set -g mouse-select-pane $new >/dev/null
  tmux set -g mouse-select-window $new >/dev/null
else
  old=$(tmux show -gv mouse)

  if [ "$old" = "on" ]; then
    new="off"
  else
    new="on"
  fi

  tmux set -g mouse $new
fi

tmux display "mouse: $new"

