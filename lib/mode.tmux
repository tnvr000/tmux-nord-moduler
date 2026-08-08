#!/usr/bin/env bash
# lib/mode.tmux

get_tmux_mode_format() {
  local is_tree="#{==:#{pane_mode},tree-mode}"
  local is_buffer="#{==:#{pane_mode},buffer-mode}"
  local is_client="#{==:#{pane_mode},client-mode}"

  local pane_mode="#{?${is_tree},TREE,#{?${is_buffer},BUFFER,#{?${is_client},OPTIONS,COPY}}}"
  local normal_mode="#{?window_zoomed_flag,ZOOM,NORMAL}"

  echo "#{?client_prefix,COMMAND,#{?pane_in_mode,${pane_mode},${normal_mode}}}"
}

get_tmux_mode_color() {
  local is_tree="#{==:#{pane_mode},tree-mode}"
  local is_buffer="#{==:#{pane_mode},buffer-mode}"
  local is_client="#{==:#{pane_mode},client-mode}"

  echo "#{?client_prefix,${THEME_MODE_COMMAND_BG},#{?pane_in_mode,#{?${is_tree},${THEME_MODE_COPY_BG},#{?${is_buffer},${THEME_MODE_OTHER_BG},#{?${is_client},${THEME_MODE_OTHER_BG},${THEME_MODE_COPY_BG}}}},#{?window_zoomed_flag,${THEME_MODE_OTHER_BG},${THEME_MODE_NORMAL_BG}}}}"
}
