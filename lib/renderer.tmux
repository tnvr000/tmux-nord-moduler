#!/usr/bin/env bash
# lib/renderer.tmux

build_right_status() {
  local -a modules_array=($NORD_RIGHT_MODULES)
  local total_modules=${#modules_array[@]}
  local output=""

  local sep_solid=""
  local sep_thin=""

  # 1. PROCESS CONFIGURABLE USER MODULES
  for (( i=0; i<$total_modules; i++ )); do
    local module="${modules_array[$i]}"
    local content=$(get_module_output "$module")
    
    content=$(echo "$content" | tr -d '\n')

    if [[ $i -eq 0 ]]; then
      output+="#[fg=${NORD_MODULE_BG},bg=default,nobold,nounderscore,noitalics]${sep_solid}"
      output+="#[fg=${NORD_MODULE_FG},bg=${NORD_MODULE_BG}] ${content}"
    else
      output+="#[fg=${NORD_MODULE_FG},bg=${NORD_MODULE_BG},nobold,nounderscore,noitalics] ${sep_thin} "
      output+="#[fg=${NORD_MODULE_FG},bg=${NORD_MODULE_BG}]${content}"
    fi
  done

  # 2. FETCH THE FIXED MODE FORMAT STRING
  local mode_content=$(get_tmux_mode_format)

  # 3. APPEND THE FIXED MODE BLOCK
  if [[ $total_modules -eq 0 ]]; then
    output+="#[fg=${NORD_ACCENT_BG},bg=default,nobold,nounderscore,noitalics]${sep_solid}"
  else
    output+="#[fg=${NORD_ACCENT_BG},bg=${NORD_MODULE_BG},nobold,nounderscore,noitalics] ${sep_solid}"
  fi

  output+="#[fg=${NORD_ACCENT_FG},bg=${NORD_ACCENT_BG},bold] ${mode_content} "

  tmux set-option -g status-right-length 150

  tmux set-option -g status-right "$output"
}

render_status() {
  build_right_status
}
