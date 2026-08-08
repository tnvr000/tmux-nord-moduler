# Tmux Nord Moduler

A beautifully clean, modular, and highly optimized Nord theme for Tmux. 

Built with a focus on **performance and cross-platform compatibility**, this plugin features zero-lag native tmux variables and hardware metrics that seamlessly bypass virtual machine limits to read physical host data in WSL, while elegantly falling back to native Linux commands when needed.

## 📸 Screenshots

![Tmux Nord Moduler Preview](./screenshots/aesthetic.png)
*Full terminal preview showcasing the Nord aesthetic.*

![Status Bar Detail](./screenshots/moduler.png)
*Detail of the hardware and git modules in action.*

---

## ✨ Features

*   **WSL-Optimized Hardware Metrics:** CPU and RAM modules query the Windows host natively, avoiding the "0% CPU" and capped RAM limits of the WSL virtual machine.
*   **Zero-Lag Navigation:** Directory and window modules use native Tmux C-variables for instant updates without bash subshell overhead.
*   **Context-Aware Git:** Real-time branch tracking with visual indicators for staged (`+`) and unstaged/dirty (`*`) changes.
*   **Highly Modular:** Easily rearrange, add, or remove modules with a single line in your `.tmux.conf`.

---

## 📦 Installation

### Option 1: Tmux Plugin Manager (Recommended)
The easiest way to install and keep the plugin updated is using [TPM](https://github.com/tmux-plugins/tpm).

1. Add the plugin to your `~/.tmux.conf`:
   ```tmux
   set -g @plugin 'tnvr000/tmux-nord-moduler'
   ```
2. Press `prefix` + `I` (capital I) to fetch and install the plugin.

### Option 2: Manual Installation
If you prefer not to use a plugin manager, you can install it manually.

1. Clone the repository anywhere on your machine:
   ```bash
   git clone https://github.com/tnvr000/tmux-nord-moduler.git ~/.tmux/plugins/tmux-nord-moduler
   ```
2. Source the plugin at the very bottom of your `~/.tmux.conf`:
   ```tmux
   run-shell ~/.tmux/plugins/tmux-nord-moduler/nord-moduler.tmux
   ```
3. Reload your Tmux configuration:
   ```bash
   tmux source ~/.tmux.conf
   ```

---

## ⚙️ Configuration

You can customize exactly which modules appear on your status bar by defining a space-separated list in your `~/.tmux.conf`. 

### Defining Modules

```tmux
# Default configuration
set -g @nord_mod_right "git directory cpu ram battery date time"
```

### Available Modules

| Module Name | Description | Architecture |
| :--- | :--- | :--- |
| `directory` | Current working directory of the active pane. | Native (Zero-lag) |
| `window` | Current Tmux window name. | Native (Zero-lag) |
| `git` | Git branch with staged (`+`) and dirty (`*`) indicators. | Bash (Context-Aware) |
| `cpu` | Total system CPU usage (WSL & Linux Native). | Bash |
| `ram` | Physical RAM usage percentage (WSL & Linux Native). | Bash |
| `battery` | System battery percentage (WSL & Linux Native). | Bash |
| `date` | Current local date (`YYYY-MM-DD`). | Bash / Tmux built-in |
| `time` | Current local time (`HH:MM`). | Bash / Tmux built-in |
| `hostname` | Name of the current machine. | Bash |

---

## 🛠️ Advanced: Adding Custom Modules

Because of the plugin's data-driven architecture, you can easily add your own custom native modules directly in your `~/.tmux.conf` without editing the plugin's source code!

Just define a bash variable with the prefix `NORD_NATIVE_` and inject your Tmux format string:

```tmux
# 1. Define a custom native module (e.g., 'user')
run-shell 'export NORD_NATIVE_user=" #(whoami)"'

# 2. Add it to your module list!
set -g @nord_mod_right "user directory git"
```

## 🛠️ Extension: Module Contract

scripts/\<name>.sh
-----------------
- Collect data only.
- Return plain text.
- No icons.
- No colors.
- No tmux formatting.
- Return empty output if there is nothing to display.

modules/\<name>.tmux
-------------------
- Source the corresponding script.
- Decide whether to display.
- Add icons.
- Format the output.
- Never collect system information directly.

## Theme contract
--------------

Every theme must define:

THEME_NAME

THEME_BASE_BG

THEME_MODULE_BG
THEME_MODULE_FG

THEME_ACCENT_BG
THEME_ACCENT_FG

THEME_MODE_FG
THEME_MODE_NORMAL_BG
THEME_MODE_COMMAND_BG
THEME_MODE_COPY_BG
THEME_MODE_OTHER_BG

--------------

## 📝 Requirements
* Tmux 2.9 or higher.
* A patched [Nerd Font](https://www.nerdfonts.com/) for icons to render correctly.
