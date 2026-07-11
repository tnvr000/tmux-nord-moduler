#!/usr/bin/env bash
# lib/helpers.tmux

# Dynamically find the modules directory relative to this helper script.
# BASH_SOURCE[0] is lib/helpers.tmux. 
# We go up one level (..) to the root, then into /modules.
MODULES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )/modules"

# Function to execute a module script and return its text
get_module_output() {
  local module_name="$1"
  local module_script="${MODULES_DIR}/${module_name}.sh"

  # Check if the requested module script actually exists
  if [ -f "$module_script" ]; then
    # Execute the script using bash and echo its output
    bash "$module_script"
  else
    # If the user makes a typo in their ~/.tmux.conf, return a safe error string
    # instead of breaking the entire status bar.
    echo "[${module_name}?]"
  fi
}
