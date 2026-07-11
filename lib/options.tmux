#!/usr/bin/env bash
# lib/options.tmux

# Helper function to get a tmux option, or return a fallback if it doesn't exist
get_tmux_option() {
  local option_name="$1"
  local default_value="$2"
  # -g: global, -q: quiet (no errors), -v: output only the value
  local option_value=$(tmux show-option -gqv "$option_name")

  if [ -z "$option_value" ]; then
    echo "$default_value"
  else
    echo "$option_value"
  fi
}

# Read the user's requested modules, falling back to the constants if empty
export NORD_RIGHT_MODULES=$(get_tmux_option "@nord_mod_right" "$DEFAULT_MODULES_RIGHT")

# We can also set up the left side for future-proofing
# export NORD_LEFT_MODULES=$(get_tmux_option "@nord_mod_left" "$DEFAULT_MODULES_LEFT")
