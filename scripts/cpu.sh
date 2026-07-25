#!/usr/bin/env bash
# modules/cpu.sh

CACHE_FILE="/tmp/tmux_nord_cpu_stat"

get_linux_cpu() {
  read -r cpu user nice system idle iowait irq softirq steal guest guest_nice < /proc/stat
  
  local current_total=$((user + nice + system + idle + iowait + irq + softirq + steal))
  local current_idle=$((idle + iowait))

  if [[ -f "$CACHE_FILE" ]]; then
    read -r prev_total prev_idle < "$CACHE_FILE"
  else
    local prev_total=0
    local prev_idle=0
  fi

  echo "$current_total $current_idle" > "$CACHE_FILE"

  local total_diff=$((current_total - prev_total))
  local idle_diff=$((current_idle - prev_idle))

  if [[ $total_diff -eq 0 || $prev_total -eq 0 ]]; then
    echo "0"
  else
    echo $((100 * (total_diff - idle_diff) / total_diff))
  fi
}

main() {
  local cpu_usage=""

  # 1. Check if we are inside WSL
  if grep -qi microsoft /proc/version; then
    # Ask Windows for the physical host CPU load percentage
    local wsl_cpu=$(cmd.exe /c "wmic cpu get loadpercentage" 2>/dev/null | tr -d '\r' | grep -o '^[0-9]\+' | head -n 1)
    
    if [[ -n "$wsl_cpu" ]]; then
      cpu_usage="$wsl_cpu"
    fi
  fi

  # 2. Fallback to native Linux calculation if not on WSL or if wmic failed
  if [[ -z "$cpu_usage" && -f /proc/stat ]]; then
    cpu_usage=$(get_linux_cpu)
  fi

  # 3. Final Fallback if everything fails
  if [[ -z "$cpu_usage" ]]; then
     echo "  --%"
     return
  fi

  # 4. Render with padding for single digits to prevent the bar from shifting
  if [[ $cpu_usage -lt 10 ]]; then
    echo "  ${cpu_usage}%"
  else
    echo "  ${cpu_usage}%"
  fi
}

main
