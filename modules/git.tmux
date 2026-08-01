#!/usr/bin/env bash

module_git() {
  local git

  git="$("$SCRIPTS_DIR/git.sh")"
  [[ -z "$git" ]] && return

  echo "  $git"
}
