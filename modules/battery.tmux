#!/usr/bin/env bash

module_battery() {
    local battery
    local capacity
    local status
    local icon

    battery="$("$SCRIPTS_DIR/battery.sh")"

    [[ -z "$battery" ]] && return

    read -r capacity status <<< "$battery"

    if [[ "$status" == *Charging* ]]; then
        icon="󰂅"
        if (( capacity <= 10 )); then
            icon="󰢟" # battery 0%
        elif (( capacity <= 20 )); then
            icon="󰢜" # battery 10%
        elif (( capacity <= 30 )); then
            icon="󰂆" # battery 20%
        elif (( capacity <= 40 )); then
            icon="󰂇" # battery 30%
        elif (( capacity <= 50 )); then
            icon="󰂈" # battery 40%
        elif (( capacity <= 60 )); then
            icon="󰢝" # battery 50%
        elif (( capacity <= 70 )); then
            icon="󰂉" # battery 60%
        elif (( capacity <= 80 )); then
            icon="󰢞" # battery 70%
        elif (( capacity <= 90 )); then
            icon="󰂊" # battery 80%
        elif (( capacity <= 100 )); then
            icon="󰂋" # battery 90%
        fi
    else
        icon="󰁹"
        if (( capacity <= 10 )); then
            icon="󰂎" # battery 0%
        elif (( capacity <= 20 )); then
            icon="󰁺" # battery 10%
        elif (( capacity <= 30 )); then
            icon="󰁻" # battery 20%
        elif (( capacity <= 40 )); then
            icon="󰁼" # battery 30%
        elif (( capacity <= 50 )); then
            icon="󰁽" # battery 40%
        elif (( capacity <= 60 )); then
            icon="󰁾" # battery 50%
        elif (( capacity <= 70 )); then
            icon="󰁿" # battery 60%
        elif (( capacity <= 80 )); then
            icon="󰂀" # battery 70%
        elif (( capacity <= 90 )); then
            icon="󰂁" # battery 80%
        elif (( capacity <= 100 )); then
            icon="󰂂" # battery 90%
        fi
    fi

    echo "${icon} ${capacity}%"
}
