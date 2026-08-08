#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

MODULES_DIR="$CURRENT_DIR/modules"
SCRIPTS_DIR="$CURRENT_DIR/scripts"

source "$CURRENT_DIR/lib/theme.tmux"
source "$CURRENT_DIR/lib/constants.tmux"
source "$CURRENT_DIR/lib/options.tmux"
source "$CURRENT_DIR/lib/mode.tmux"
source "$CURRENT_DIR/lib/renderer.tmux"

render_status
