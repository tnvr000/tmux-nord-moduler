#!/usr/bin/env bash
# lib/mode.tmux

get_tmux_mode_format() {
  local is_tree="#{==:#{pane_mode},tree-mode}"
  local is_buffer="#{==:#{pane_mode},buffer-mode}"
  local is_client="#{==:#{pane_mode},client-mode}"
  
  local check_advanced_modes="#{?${is_tree},CHOOSE,#{?${is_buffer},CHOOSE,#{?${is_client},OPTIONS,COPY}}}"
  local check_pane_mode="#{?pane_in_mode,${check_advanced_modes},#{?window_zoomed_flag,ZOOM,NORMAL}}"
  
  # Output the final nested conditional string
  echo "#{?client_prefix,COMMAND,${check_pane_mode}}"
}
