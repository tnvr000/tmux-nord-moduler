# Tmux Nord Moduler

A modular and customizable tmux status bar with multiple themes.

Modules are independent components that collect and format information such as Git status, CPU usage, RAM usage, battery level, date, and time. You can easily choose which modules appear and in what order.

## 📸 Screenshots

![Tmux Nord Moduler Preview](./screenshots/aesthetic.png)

*Full terminal preview.*

![Status Bar Detail](./screenshots/moduler.png)

*Status bar modules in action.*

---

## ✨ Features

* **Modular design** — Add, remove, or reorder modules through your `.tmux.conf`.
* **Git integration** — Displays the current branch with staged (`+`) and dirty (`*`) indicators.
* **System information** — CPU, RAM, battery, hostname, and user modules.
* **Context-aware modules** — Modules such as Git automatically hide themselves when there is nothing relevant to display.
* **Multiple themes** — Includes Nord, Oasis, and Canopy.
* **Extensible architecture** — Modules and data collection scripts are kept separate.

---

## 📦 Installation

### Option 1: Tmux Plugin Manager

Add the plugin to your `~/.tmux.conf`:

```tmux
set -g @plugin 'tnvr000/tmux-nord-moduler'
```

Press `prefix` + `I` to install it.

### Option 2: Manual Installation

Clone the repository:

```bash
git clone https://github.com/tnvr000/tmux-nord-moduler.git ~/.tmux/plugins/tmux-nord-moduler
```

Add the following near the bottom of your `~/.tmux.conf`:

```tmux
run-shell ~/.tmux/plugins/tmux-nord-moduler/nord-moduler.tmux
```

Reload tmux:

```bash
tmux source ~/.tmux.conf
```

---

# ⚙️ Configuration

## Choosing Modules

The right side of the status bar is controlled with `@nord_mod_right`.

Modules are specified as a space-separated list.

```tmux
set -g @nord_mod_right "git directory cpu ram battery date time"
```

The order in the configuration is the order in which modules appear in the status bar.

For example:

```tmux
set -g @nord_mod_right "user hostname git directory"
```

Modules that return no output are automatically skipped without leaving unnecessary separators.

---

## Available Modules

| Module      | Description                                                                  |
| ----------- | ---------------------------------------------------------------------------- |
| `git`       | Current Git branch with staged (`+`) and dirty (`*`) indicators.             |
| `directory` | Current working directory of the active pane.                                |
| `cpu`       | Current CPU usage percentage.                                                |
| `ram`       | Current RAM usage percentage.                                                |
| `battery`   | Battery percentage and charging status. Hidden when no battery is available. |
| `date`      | Current date.                                                                |
| `time`      | Current time.                                                                |
| `hostname`  | Hostname of the current machine.                                             |
| `user`      | Current username.                                                            |

The default configuration is:

```tmux
set -g @nord_mod_right "git directory cpu ram battery date time"
```

---

# 🎨 Themes

The plugin currently includes three themes:

* `nord`
* `oasis`
* `canopy`

Select a theme using `@nord_mod_theme`:

```tmux
set -g @nord_mod_theme "canopy"
```

If no theme is configured, the plugin uses `nord`.

```tmux
set -g @nord_mod_theme "nord"
```

If an invalid theme name is provided, the plugin falls back to Nord.

---

# 🛠️ Creating Custom Modules

Each module consists of two layers:

```text
scripts/<name>.sh
        ↓
modules/<name>.tmux
        ↓
dispatcher.sh
        ↓
status bar
```

The script is responsible for collecting data.

The module is responsible for deciding how that data should be displayed.

For example:

```text
scripts/weather.sh
modules/weather.tmux
```

Then add the module to your configuration:

```tmux
set -g @nord_mod_right "git weather cpu time"
```

## Script Contract

`scripts/<name>.sh`

Scripts should:

* Collect data only.
* Return plain text.
* Avoid icons and colors.
* Avoid tmux formatting.
* Return empty output when there is nothing to display.

Example:

```bash
#!/usr/bin/env bash

echo "24°C"
```

## Module Contract

`modules/<name>.tmux`

A module should:

* Define a function named `module_<name>`.
* Call the corresponding script when necessary.
* Decide whether the module should be displayed.
* Add icons and presentation formatting.
* Avoid directly collecting system information.

Example:

```bash
#!/usr/bin/env bash

module_weather() {
  local weather

  weather="$("$SCRIPTS_DIR/weather.sh")"

  [[ -z "$weather" ]] && return

  echo "󰖨  $weather"
}
```

The module name and function name must match:

```text
modules/weather.tmux
module_weather()
```

---

# 🎨 Theme Contract

Every theme file must define the colors used by the status bar.

At minimum:

```bash
THEME_NAME

THEME_BASE_BG
THEME_STATUS_BG

THEME_MODULE_BG
THEME_MODULE_FG

THEME_ACCENT_BG
THEME_ACCENT_FG

THEME_MODE_FG
THEME_MODE_NORMAL_BG
THEME_MODE_COMMAND_BG
THEME_MODE_COPY_BG
THEME_MODE_OTHER_BG
```

Theme files are stored in:

```text
themes/
```

For example:

```text
themes/nord.tmux
themes/oasis.tmux
themes/canopy.tmux
```

---

# 📝 Requirements

* tmux 2.9 or later.
* A patched [Nerd Font](https://www.nerdfonts.com/) for icons to render correctly.
