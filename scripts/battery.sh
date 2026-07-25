#!/usr/bin/env bash

get_battery_wsl() {
  # We use wmic via cmd.exe because it is significantly faster than calling powershell.exe from WSL
  local capacity=$(cmd.exe /c "wmic path Win32_Battery get EstimatedChargeRemaining" 2>/dev/null | tr -d '\r' | grep -o '^[0-9]\+')
  local status_code=$(cmd.exe /c "wmic path Win32_Battery get BatteryStatus" 2>/dev/null | tr -d '\r' | grep -o '^[0-9]\+')
  
  # Win32_Battery BatteryStatus: 2 = AC/Charging, 1 = Discharging
  local status="Discharging"
  if [[ "$status_code" == "2" ]]; then
      status="Charging"
  fi
  
  if [[ -n "$capacity" ]]; then
      echo "$capacity $status"
  fi
}

main() {
  local capacity=""
  local status=""

  # 1. Check for standard Linux
  if [[ -f /sys/class/power_supply/BAT0/capacity ]]; then
      capacity=$(cat /sys/class/power_supply/BAT0/capacity)
      status=$(cat /sys/class/power_supply/BAT0/status)
      
  # 2. Check for macOS
  elif command -v pmset >/dev/null 2>&1; then
      capacity=$(pmset -g batt | grep -o '[0-9]\{1,3\}%' | tr -d '%')
      status=$(pmset -g batt | grep -o 'charging\|discharging')
      
  # 3. Check for WSL (Ubuntu 22)
  elif grep -qi microsoft /proc/version; then
      read -r capacity status <<< "$(get_battery_wsl)"
  fi

  # Fallback if no battery is detected (e.g., on a desktop)
  if [[ -z "$capacity" ]]; then
    return
  fi

  # Output the final string to tmux
  echo "$capacity $status"
}

main
