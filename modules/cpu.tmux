module_cpu() {
    local cpu

    cpu="$("$CURRENT_DIR/scripts/cpu.sh")"

    echo "$cpu"
}
