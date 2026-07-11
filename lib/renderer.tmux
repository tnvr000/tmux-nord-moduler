#!/usr/bin/env bash
# lib/renderer.tmux

build_right_status() {
  # Convert the string of modules (e.g., "date time user") into an array
  local -a modules_array=($NORD_RIGHT_MODULES)
  local total_modules=${#modules_array[@]}
  local output=""

  for (( i=0; i<$total_modules; i++ )); do
    local module="${modules_array[$i]}"
    local content=$(get_module_output "$module")
    
    if [[ $i -eq 0 ]]; then
      # 1. THE FIRST MODULE
      # Transition from the default tmux background to the colored module block
      if [[ $total_modules -eq 1 ]]; then
          # Edge case: If there is ONLY one module, make it the Accent color
          output+="#[fg=${NORD_ACCENT_BG},bg=default,nobold,nounderscore,noitalics]${SEP_SOLID_LEFT}"
          output+="#[fg=${NORD_ACCENT_FG},bg=${NORD_ACCENT_BG},bold] ${content} "
      else
          # Standard start: Use the Bright Black background
          output+="#[fg=${NORD_MODULE_BG},bg=default,nobold,nounderscore,noitalics]${SEP_SOLID_LEFT}"
          output+="#[fg=${NORD_MODULE_FG},bg=${NORD_MODULE_BG}] ${content} "
      fi

    elif [[ $i -eq $((total_modules - 1)) ]]; then
      # 2. THE LAST MODULE (The Accent)
      # Transition from Bright Black (MODULE_BG) to Cyan (ACCENT_BG) using the solid separator
      output+="#[fg=${NORD_ACCENT_BG},bg=${NORD_MODULE_BG},nobold,nounderscore,noitalics]${SEP_SOLID_LEFT}"
      output+="#[fg=${NORD_ACCENT_FG},bg=${NORD_ACCENT_BG},bold] ${content} "

    else
      # 3. MIDDLE MODULES
      # Standard modules sharing the same background use the thin separator (⟨)
      output+="#[fg=${NORD_MODULE_FG},bg=${NORD_MODULE_BG}]${SEP_THIN_LEFT}"
      output+="#[fg=${NORD_MODULE_FG},bg=${NORD_MODULE_BG}] ${content} "
    fi
  done

  # Finally, inject the compiled string into tmux
  tmux set-option -g status-right "$output"
}

render_status() {
  # We can easily add build_left_status() here in the future!
  build_right_status
}
