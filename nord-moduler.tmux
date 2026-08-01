#!/usr/bin/env bash
# nord-moduler.tmux

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
MODULES_DIR="${CURRENT_DIR}/modules"
SCRIPTS_DIR="${CURRENT_DIR}/scripts"

# Source the library files in dependency order
source "$CURRENT_DIR/lib/colors.tmux"
source "$CURRENT_DIR/lib/constants.tmux"
source "$CURRENT_DIR/lib/options.tmux"
source "$CURRENT_DIR/lib/mode.tmux"
source "$CURRENT_DIR/lib/renderer.tmux"

main() {
  render_status
}

main
