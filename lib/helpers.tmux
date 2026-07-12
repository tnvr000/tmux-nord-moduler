#!/usr/bin/env bash
# lib/helpers.tmux

MODULES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )/modules"

get_module_tag() {
  # Strip invisible whitespace/carriage returns just to be safe
  local module_name=$(echo "$1" | tr -d '\r\n[:space:]')
  
  # 1. Dynamic Variable Indirection (The Clean Way!)
  local var_name="NORD_NATIVE_${module_name}"
  local native_format="${!var_name}"
  
  # If it finds the native variable, return it instantly
  if [[ -n "$native_format" ]]; then
    echo "$native_format"
    return
  fi

  # 2. Bash Script Fallback
  local module_script="${MODULES_DIR}/${module_name}.sh"

  if [[ ! -f "$module_script" ]]; then
    echo "[${module_name}?]"
  else
    echo "#(bash \"$module_script\")"
  fi
}
