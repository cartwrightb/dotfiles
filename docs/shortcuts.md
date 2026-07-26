# Keyboard Shortcuts

This is the reference for shortcuts managed by this repository and shortcuts
inherited from Fedora's Sway configuration. Keep it updated when bindings
change.

`Super` is the Windows-logo key (`Mod4`). Letter keys are shown uppercase for
readability; they do not require Shift unless `Shift` is explicitly listed.
Laptop media, brightness, and Print keys may also require `Fn`.

## Sway

### Applications and session

| Shortcut | Action | Source |
| --- | --- | --- |
| `Super+Enter` | Open Alacritty | Repository |
| `Super+D` | Open Rofi | Repository |
| `Super+Shift+Q` | Close the focused window | Fedora main config |
| `Super+Shift+C` | Reload Sway | Fedora main config |
| `Super+Shift+E` | Show the exit confirmation | Fedora main config |

### Focus and movement

| Shortcut | Action |
| --- | --- |
| `Super+H/J/K/L` | Focus left/down/up/right |
| `Super+Arrow` | Focus in the arrow direction |
| `Super+Shift+H/J/K/L` | Move the focused window left/down/up/right |
| `Super+Shift+Arrow` | Move the focused window in the arrow direction |
| `Super+A` | Focus the parent container |
| `Super+Space` | Switch focus between tiled and floating windows |

### Workspaces

| Shortcut | Action |
| --- | --- |
| `Super+1` … `Super+9` | Switch to workspace 1–9 |
| `Super+0` | Switch to workspace 10 |
| `Super+Shift+1` … `Super+Shift+9` | Move the focused window to workspace 1–9 |
| `Super+Shift+0` | Move the focused window to workspace 10 |

### Layout and floating

| Shortcut | Action |
| --- | --- |
| `Super+B` | Set a horizontal split |
| `Super+V` | Set a vertical split |
| `Super+S` | Use stacking layout |
| `Super+W` | Use tabbed layout |
| `Super+E` | Toggle the split layout |
| `Super+F` | Toggle fullscreen |
| `Super+Shift+Space` | Toggle the focused window between tiled and floating |

### Resize mode

| Shortcut | Action |
| --- | --- |
| `Super+R` | Enter resize mode |
| `H` or `Left` | Shrink width |
| `L` or `Right` | Grow width |
| `K` or `Up` | Shrink height |
| `J` or `Down` | Grow height |
| `Enter` or `Escape` | Leave resize mode |

Each resize step is 10 pixels.

### Scratchpad and passthrough

| Shortcut | Action |
| --- | --- |
| `Super+Shift+-` | Move the focused window to the scratchpad |
| `Super+-` | Show or hide the next scratchpad window |
| `Super+Pause` | Enter or leave passthrough mode |

Passthrough mode temporarily stops normal Sway bindings from intercepting keys,
apart from `Super+Pause`, so the focused application can receive them.

### Mouse

| Shortcut | Action |
| --- | --- |
| `Super+Left drag` | Move a window |
| `Super+Right drag` | Resize a window |

## Screenshots

Saved captures are written to `~/Pictures/Screenshots`. Clipboard captures can
be pasted directly into applications that accept PNG image data.

| Shortcut | Action |
| --- | --- |
| `Print` | Save the active output |
| `Alt+Print` | Save the active window |
| `Ctrl+Print` | Save a selected area |
| `Super+Shift+S` | Copy a selected area |
| `Super+Shift+W` | Copy the active window |
| `Super+Shift+O` | Copy the active output |

## Hardware and media keys

These bindings are inherited from Fedora's Sway snippets.

| Key | Action |
| --- | --- |
| `Brightness down/up` | Change display brightness by 5% |
| `Volume down/up` | Change output volume |
| `Volume mute` | Toggle output mute |
| `Microphone mute` | Toggle microphone mute |
| `Play` | Toggle play/pause |
| `Pause` | Pause playback |
| `Stop` | Stop playback |
| `Previous/Next` | Select the previous or next track |
| `Rewind/Forward` | Seek backward or forward by 10 seconds |

Brightness and volume changes display a short notification when
`notify-send` is available. Volume, mute, play, and stop bindings continue to
work while the screen is locked where Fedora marks them as locked bindings.

## Waybar pointer actions

| Target | Action |
| --- | --- |
| Workspace | Click to switch workspace |
| Network | Left-click to open NetworkManager's connection editor |
| Volume | Scroll to change volume by 5% |
| Volume | Left-click to open Pavucontrol |
| Volume | Right-click to toggle mute |
| Date and time | Left-click to open Google Calendar |

## Future application shortcuts

Application-specific bindings such as Tmux can remain in this file under their
own top-level sections. Split them into separate files under `docs/shortcuts/`
only if this reference becomes difficult to scan.

