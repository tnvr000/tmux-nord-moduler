#!/usr/bin/env bash
# modules/battery.sh

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
      local wsl_bat=$(get_battery_wsl)
      capacity=$(echo "$wsl_bat" | awk '{print $1}')
      status=$(echo "$wsl_bat" | awk '{print $2}')
  fi

  # Fallback if no battery is detected (e.g., on a desktop)
  if [[ -z "$capacity" ]]; then
      echo "󰂑 ---%"
      return
  fi

  # Determine the correct Nerd Font icon
  local icon="󰁹" # Default full
  
  if [[ "$status" == *"Charging"* ]] || [[ "$status" == *"charging"* ]]; then
      icon="󰂄"
  else
      if [[ $capacity -le 20 ]]; then
          icon="󰂎"
      elif [[ $capacity -le 50 ]]; then
          icon="󰁾"
      elif [[ $capacity -le 80 ]]; then
          icon="󰂀"
      fi
  fi

  # Output the final string to tmux
  echo "${icon} ${capacity}%"
}

main
