module_cpu() {
    local cpu

    cpu="$("$SCRIPTS_DIR/cpu.sh")"

    echo "  $cpu%"
}
