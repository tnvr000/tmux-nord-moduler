#!/usr/bin/env bash

get_tmux_mode_segment() {
  local separator_bg="$1"

  local is_tree="#{==:#{pane_mode},tree-mode}"
  local is_buffer="#{==:#{pane_mode},buffer-mode}"
  local is_client="#{==:#{pane_mode},client-mode}"

  # Commas inside #{?...,...,...} branches must be escaped for tmux.
  local normal="#[fg=${THEME_MODE_NORMAL_BG}#,bg=${separator_bg}#,nobold#,nounderscore#,noitalics] #[fg=${THEME_MODE_FG}#,bg=${THEME_MODE_NORMAL_BG}#,bold] NORMAL "
  local command="#[fg=${THEME_MODE_COMMAND_BG}#,bg=${separator_bg}#,nobold#,nounderscore#,noitalics] #[fg=${THEME_MODE_FG}#,bg=${THEME_MODE_COMMAND_BG}#,bold] COMMAND "
  local copy="#[fg=${THEME_MODE_COPY_BG}#,bg=${separator_bg}#,nobold#,nounderscore#,noitalics] #[fg=${THEME_MODE_FG}#,bg=${THEME_MODE_COPY_BG}#,bold] COPY "
  local tree="#[fg=${THEME_MODE_COPY_BG}#,bg=${separator_bg}#,nobold#,nounderscore#,noitalics] #[fg=${THEME_MODE_FG}#,bg=${THEME_MODE_COPY_BG}#,bold] TREE "
  local buffer="#[fg=${THEME_MODE_OTHER_BG}#,bg=${separator_bg}#,nobold#,nounderscore#,noitalics] #[fg=${THEME_MODE_FG}#,bg=${THEME_MODE_OTHER_BG}#,bold] BUFFER "
  local options="#[fg=${THEME_MODE_OTHER_BG}#,bg=${separator_bg}#,nobold#,nounderscore#,noitalics] #[fg=${THEME_MODE_FG}#,bg=${THEME_MODE_OTHER_BG}#,bold] OPTIONS "
  local zoom="#[fg=${THEME_MODE_OTHER_BG}#,bg=${separator_bg}#,nobold#,nounderscore#,noitalics] #[fg=${THEME_MODE_FG}#,bg=${THEME_MODE_OTHER_BG}#,bold] ZOOM "

  echo "#{?client_prefix,${command},#{?pane_in_mode,#{?${is_tree},${tree},#{?${is_buffer},${buffer},#{?${is_client},${options},${copy}}}},#{?window_zoomed_flag,${zoom},${normal}}}}"
}
