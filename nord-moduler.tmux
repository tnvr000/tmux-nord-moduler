#!/usr/bin/env bash
# nord-moduler.tmux

# 1. Get the current directory of this script
# This is crucial so TPM can find your files regardless of where the user installed them.
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# 2. Source the library files in order of dependency
source "$CURRENT_DIR/lib/colors.tmux"
source "$CURRENT_DIR/lib/constants.tmux"
source "$CURRENT_DIR/lib/options.tmux"
source "$CURRENT_DIR/lib/helpers.tmux"
source "$CURRENT_DIR/lib/renderer.tmux"

# 3. Execute the main rendering function
# (We will define this function inside lib/renderer.tmux)
main() {
  # This function will eventually call build_status_right, etc.
  render_status
}

main
