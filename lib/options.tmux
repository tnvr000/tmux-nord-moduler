#!/usr/bin/env bash
# lib/options.tmux

get_tmux_option() {
  local option_name="$1"
  local default_value="$2"
  local option_value=$(tmux show-option -gqv "$option_name")

  if [ -z "$option_value" ]; then
    echo "$default_value"
  else
    echo "$option_value"
  fi
}

NORD_RIGHT_MODULES=$(get_tmux_option "@nord_mod_right" "$DEFAULT_MODULES_RIGHT")
