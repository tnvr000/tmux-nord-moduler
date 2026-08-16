#!/usr/bin/env bash

apply_theme() {
  tmux set-option -g status-style "bg=${THEME_STATUS_BG},fg=${THEME_STATUS_FG}"

  tmux set-option -g pane-border-style "bg=default,fg=${THEME_PANE_BORDER}"

  tmux set-option -g pane-active-border-style "bg=default,fg=${THEME_PANE_ACTIVE_BORDER}"

  tmux set-option -g status-left \
  "#[fg=${THEME_SESSION_FG},bg=${THEME_SESSION_BG},bold] #S #[fg=${THEME_SESSION_BG},bg=${THEME_STATUS_BG},nobold]"

  tmux set-option -g window-status-format "#[fg=${THEME_STATUS_BG},bg=${THEME_WINDOW_BG},nobold,noitalics,nounderscore] #[fg=${THEME_WINDOW_FG},bg=${THEME_WINDOW_BG}]#I #[fg=${THEME_WINDOW_FG},bg=${THEME_WINDOW_BG},nobold,noitalics,nounderscore] #[fg=${THEME_WINDOW_FG},bg=${THEME_WINDOW_BG}]#W #F #[fg=${THEME_WINDOW_BG},bg=${THEME_STATUS_BG},nobold,noitalics,nounderscore]"

  tmux set-option -g window-status-current-format "#[fg=${THEME_STATUS_BG},bg=${THEME_WINDOW_CURRENT_BG},nobold,noitalics,nounderscore] #[fg=${THEME_WINDOW_CURRENT_FG},bg=${THEME_WINDOW_CURRENT_BG}]#I #[fg=${THEME_WINDOW_CURRENT_FG},bg=${THEME_WINDOW_CURRENT_BG},nobold,noitalics,nounderscore] #[fg=${THEME_WINDOW_CURRENT_FG},bg=${THEME_WINDOW_CURRENT_BG}]#W #F #[fg=${THEME_WINDOW_CURRENT_BG},bg=${THEME_STATUS_BG},nobold,noitalics,nounderscore]"

  tmux set-option -g window-status-separator ""
}
