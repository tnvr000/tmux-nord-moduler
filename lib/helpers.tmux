#!/usr/bin/env bash
# lib/helpers.tmux

MODULES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )/modules"

get_module_tag() {
  local module_name="$1"
  local module_script="${MODULES_DIR}/${module_name}.sh"

  if [[ ! -f "$module_script" ]]; then
    echo "[${module_name}?]"
  else
    # Instead of executing it, we output the tmux dynamic execution tag.
    # Tmux will run this script every time 'status-interval' ticks!
    echo "#(bash \"$module_script\")"
  fi
}
