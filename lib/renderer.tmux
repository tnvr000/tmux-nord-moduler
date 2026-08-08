#!/usr/bin/env bash
# lib/renderer.tmux

apply_style() {
  local fg="$1"
  local bg="$2"
  local attrs="$3"
  local text="$4"

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
  local -a visible_modules=()

  local sep_solid=""
  local sep_thin=""
  local reset="nobold,nounderscore,noitalics"

  for module in "${modules_array[@]}"; do
    local content

    content="$("$SCRIPTS_DIR/dispatcher.sh" "$module")"

    [[ -z "$content" ]] && continue

    visible_modules+=("$content")
  done

  local total_visible=${#visible_modules[@]}
  for (( i=0; i<$total_visible; i++ )); do
    local content="${visible_modules[$i]}"

    if [[ $i -eq 0 ]]; then
      output+=$(apply_style "$THEME_MODULE_BG" "default" "$reset" "$sep_solid")
      output+=$(apply_style "$THEME_MODULE_FG" "$THEME_MODULE_BG" "" " ${content}")
    else
      output+=$(apply_style "$THEME_MODULE_FG" "$THEME_MODULE_BG" "$reset" " ${sep_thin} ")
      output+=$(apply_style "$THEME_MODULE_FG" "$THEME_MODULE_BG" "" "${content}")
    fi
  done

  local mode_content="$(get_tmux_mode_format)"
  local mode_bg="$(get_tmux_mode_color)"

  if [[ $total_visible -eq 0 ]]; then
  output+=$(apply_style "$mode_bg" "default" "$reset" "$sep_solid")
else
  output+=$(apply_style "$mode_bg" "$THEME_MODULE_BG" "$reset" " ${sep_solid}")
fi

output+=$(apply_style "$THEME_MODE_FG" "$mode_bg" "bold" " ${mode_content} ")

  echo "$output"
}

render_status() {
  build_right_status
}
