#!/usr/bin/env bash
# lib/renderer.tmux

# --- STYLING WRAPPER ---
# usage: apply_style <fg_color> <bg_color> <attributes> <text>
apply_style() {
  local fg="$1"
  local bg="$2"
  local attrs="$3"
  local text="$4"

  # If attributes (like bold) are provided, add them with a comma
  if [[ -n "$attrs" ]]; then
    echo -n "#[fg=${fg},bg=${bg},${attrs}]${text}"
  else
    echo -n "#[fg=${fg},bg=${bg}]${text}"
  fi
}

build_right_status() {
  local -a modules_array=($NORD_RIGHT_MODULES)
  local total_modules=${#modules_array[@]}
  local output=""

  local sep_solid=""
  local sep_thin=""
  local reset="nobold,nounderscore,noitalics" # Storing this removes so much visual clutter

  # 1. PROCESS CONFIGURABLE USER MODULES
  for (( i=0; i<$total_modules; i++ )); do
    local module="${modules_array[$i]}"
    
    # Execute the module and strip newlines in one clean step
    local content=$(get_module_output "$module" | tr -d '\n')

    if [[ $i -eq 0 ]]; then
      output+=$(apply_style "$NORD_MODULE_BG" "default" "$reset" "$sep_solid")
      output+=$(apply_style "$NORD_MODULE_FG" "$NORD_MODULE_BG" "" " ${content}")
    else
      output+=$(apply_style "$NORD_MODULE_FG" "$NORD_MODULE_BG" "$reset" " ${sep_thin} ")
      output+=$(apply_style "$NORD_MODULE_FG" "$NORD_MODULE_BG" "" "${content}")
    fi
  done

  # 2. FETCH THE FIXED MODE FORMAT STRING
  local mode_content=$(get_tmux_mode_format)

  # 3. APPEND THE FIXED MODE BLOCK
  if [[ $total_modules -eq 0 ]]; then
    output+=$(apply_style "$NORD_ACCENT_BG" "default" "$reset" "$sep_solid")
  else
    output+=$(apply_style "$NORD_ACCENT_BG" "$NORD_MODULE_BG" "$reset" " ${sep_solid}")
  fi

  output+=$(apply_style "$NORD_ACCENT_FG" "$NORD_ACCENT_BG" "bold" " ${mode_content} ")

  tmux set-option -g status-right-length 150
  tmux set-option -g status-right "$output"
}

render_status() {
  build_right_status
}
