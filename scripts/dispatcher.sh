#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
MODULES_DIR="$CURRENT_DIR/modules"
SCRIPTS_DIR="$CURRENT_DIR/scripts"

module_name="$1"
module_file="$MODULES_DIR/${module_name}.tmux"

if [[ ! -f "$module_file" ]]; then
    echo "[${module_name}?]"
    exit 0
fi

source "$module_file"

module_function="module_${module_name}"

if ! declare -F "$module_function" >/dev/null; then
    echo "[${module_name}?]"
    exit 0
fi

"$module_function"
