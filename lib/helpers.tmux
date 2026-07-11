#!/usr/bin/env bash
# lib/helpers.tmux

MODULES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )/modules"

get_module_tag() {
  local module_name=$(echo "$1" | tr -d '\r\n[:space:]')

  # 1. HARDCODED NATIVE VARIABLES
  case "$module_name" in
    directory)
      echo "  #{b:pane_current_path}"
      return
      ;;
    session)
      echo " #S"
      return
      ;;
    window)
      echo " #W"
      return
      ;;
  esac

  # 2. BASH SCRIPT FALLBACK
  local module_script="${MODULES_DIR}/${module_name}.sh"

  if [[ ! -f "$module_script" ]]; then
    echo "[${module_name}?]"
  else
    echo "#(bash \"$module_script\")"
  fi
}
