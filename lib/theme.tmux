#!/usr/bin/env bash

THEME="$(tmux show-option -gqv @nord_mod_theme)"
THEME="${THEME:-nord}"

THEME_FILE="$CURRENT_DIR/themes/${THEME}.tmux"

if [[ ! -f "$THEME_FILE" ]]; then
  THEME="nord"
  THEME_FILE="$CURRENT_DIR/themes/${THEME}.tmux"
fi

source "$THEME_FILE"
