#!/usr/bin/env bash

apply_terminal_color() {
  local type="$1"
  local value="$2"
  local target_tty="$3"

  [ -n "$target_tty" ] || return 1
  [ -w "$target_tty" ] || return 1

  printf '\033]%s;%s\007' "$type" "$value" > "$target_tty"
}

apply_terminal_colors_to_tty() {
  local target_tty="$1"

  [ -n "$target_tty" ] || return 1
  [ -w "$target_tty" ] || return 1

  apply_terminal_color "10" "$THEME_FG" "$target_tty"
  apply_terminal_color "11" "$THEME_BG" "$target_tty"
  apply_terminal_color "12" "$THEME_CURSOR" "$target_tty"

  for i in {0..15}; do
    local color_var="THEME_COLOR_${i}"
    local color="${!color_var}"

    [ -n "$color" ] || continue

    apply_terminal_color "4;${i}" "$color" "$target_tty"
  done
}

register_terminal_theme_hook() {
  tmux set-hook -g client-attached[nord-theme-colors] \
    "run-shell 'bash \"$CURRENT_DIR/lib/terminal_theme_apply.tmux\" apply-to-tty \"#{client_tty}\"'"
}

apply_terminal_colors() {
  local override

  override="$(tmux show-option -gqv @nord_mod_terminal_theme_override)"

  [ "$override" = "on" ] || return 0

  register_terminal_theme_hook

  (
    for i in {1..10}; do
      local ttys
      ttys="$(tmux list-clients -F '#{client_tty}' 2>/dev/null)"

      if [ -n "$ttys" ]; then
        while IFS= read -r tty; do
          apply_terminal_colors_to_tty "$tty"
        done <<< "$ttys"

        break
      fi

      sleep 0.2
    done
  ) &
}

# Command mode used by the tmux client-attached hook.
if [ "$1" = "apply-to-tty" ]; then
  target_tty="$2"

  # The command shell needs the theme variables.
  source "$CURRENT_DIR/lib/theme.tmux"

  apply_terminal_colors_to_tty "$target_tty"
fi
