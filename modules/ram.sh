#!/usr/bin/env bash
# modules/ram.sh

get_ram_wsl() {
  # Ask Windows for physical host memory (returned in Kilobytes)
  local wsl_mem=$(cmd.exe /c "wmic OS get FreePhysicalMemory,TotalVisibleMemorySize /Value" 2>/dev/null | tr -d '\r')
  
  local free_kb=$(echo "$wsl_mem" | grep -i "FreePhysicalMemory" | cut -d'=' -f2)
  local total_kb=$(echo "$wsl_mem" | grep -i "TotalVisibleMemorySize" | cut -d'=' -f2)

  if [[ -n "$free_kb" && -n "$total_kb" && "$total_kb" -gt 0 ]]; then
    local used_kb=$((total_kb - free_kb))
    # Calculate the percentage
    echo $(( 100 * used_kb / total_kb ))
  fi
}

get_ram_linux() {
  # Standard Linux fallback using the 'free' command
  if command -v free >/dev/null 2>&1; then
    local mem_info=$(free -m | awk 'NR==2{print $2, $3}')
    local total_mb=$(echo "$mem_info" | awk '{print $1}')
    local used_mb=$(echo "$mem_info" | awk '{print $2}')
    
    if [[ -n "$total_mb" && "$total_mb" -gt 0 ]]; then
       echo $(( 100 * used_mb / total_mb ))
    fi
  fi
}

main() {
  local ram_usage=""

  # 1. Check if we are inside WSL
  if grep -qi microsoft /proc/version 2>/dev/null; then
    ram_usage=$(get_ram_wsl)
  fi

  # 2. Fallback to native Linux calculation if not on WSL
  if [[ -z "$ram_usage" ]]; then
    ram_usage=$(get_ram_linux)
  fi

  # 3. Final Fallback if everything fails
  if [[ -z "$ram_usage" ]]; then
     echo "󰍛 --%"
     return
  fi

  # 4. Render with padding for single digits to prevent the bar from shifting
  if [[ $ram_usage -lt 10 ]]; then
    echo "  ${ram_usage}%"
  else
    echo "  ${ram_usage}%"
  fi
}

main
