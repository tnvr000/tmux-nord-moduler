#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
MODULES_DIR="$CURRENT_DIR/modules"
SCRIPTS_DIR="$CURRENT_DIR/scripts"

module_not_found() {
  echo "[${module_name}?]"
  exit 0
}

module_name="$1"
module_file="$MODULES_DIR/${module_name}.tmux"
[[ -f "$module_file" ]] || module_not_found

source "$module_file"
module_function="module_${module_name}"
declare -F "$module_function" >/dev/null || module_not_found

"$module_function"
