#!/usr/bin/env bash
# lib/helpers.tmux

MODULES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )/modules"

get_module_output() {
  local module_name="$1"
  local module_script="${MODULES_DIR}/${module_name}.sh"

  # Safety Check 1: Does the script actually exist?
  if [[ ! -f "$module_script" ]]; then
    echo "[${module_name}?]"
    return 1
  fi

  # Safety Check 2: Execute the script, but swallow standard error (2>/dev/null)
  # This prevents bash errors from printing into the tmux status bar
  local output
  output=$(bash "$module_script" 2>/dev/null)

  # Safety Check 3: Did the script execute but return absolutely nothing?
  if [[ -z "$output" ]]; then
    echo "[-]"
  else
    echo "$output"
  fi
}
