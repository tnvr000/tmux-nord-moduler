#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "$0" )/.." && pwd )"

MODULES_DIR="$CURRENT_DIR/modules"
SCRIPTS_DIR="$CURRENT_DIR/scripts"

module_name="$1"
module_file="$MODULES_DIR/${module_name}.tmux"
script_file="$SCRIPTS_DIR/${module_name}.sh"
legacy_script="$MODULES_DIR/${module_name}.sh"

if [[ -f "$module_file" ]]; then
    source "$module_file"
    module_function="module_${module_name}"

    if declare -F "$module_function" >/dev/null; then
        "$module_function"
        exit 0
    fi
fi

if [[ -f "$script_file" ]]; then
    bash "$script_file"
    exit 0
fi

if [[ -f "$legacy_script" ]]; then
    bash "$legacy_script"
    exit 0
fi

echo "[${module_name}?]"
