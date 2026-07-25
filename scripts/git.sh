#!/usr/bin/env bash

main() {
  # 1. Ask Tmux for the current path of the active pane
  local pane_path=$(tmux display-message -p "#{pane_current_path}")

  # 2. Navigate to that directory
  cd "$pane_path" 2>/dev/null || return

  # 3. Check if we are inside a Git repository
  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "--"
    return
  fi

  # 4. Get the current branch name
  local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

  local staged=""
  local dirty=""

  # 5. Check for staged changes
  # --quiet returns an exit code of 1 if there are differences
  if ! git diff --cached --quiet 2>/dev/null; then
    staged="+"
  fi

  # 6. Check for unstaged changes (modified files) OR untracked files
  if ! git diff --quiet 2>/dev/null || [[ -n $(git ls-files --others --exclude-standard 2>/dev/null) ]]; then
    dirty="*"
  fi

  # Output the final string (e.g., main, main*, main+, or main+*)
  echo "${branch}${staged}${dirty}"
}

main
