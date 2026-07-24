# Fedora Sway Dotfiles

Minimal user configuration for a Fedora Sway workstation, deployed into
`$HOME` with GNU Stow.

The repository is intentionally incremental. It contains only configuration
that has been reviewed and chosen; Fedora and application defaults remain in
effect everywhere else.

## Repository Layout

Each top-level application directory is a Stow package. Its contents reproduce
the path below `$HOME`.

```text
dotfiles/
├── sway/
│   └── .config/
│       └── sway/
│           └── config
├── alacritty/
│   └── .config/
│       └── alacritty/
│           └── alacritty.toml
├── rofi/
│   └── .config/
│       └── rofi/
│           ├── config.rasi
│           └── theme.rasi
├── shell/
│   └── .bashrc.d/
│       └── 20-prompt.sh
├── zed/
│   └── .config/
│       └── zed/
│           └── settings.json
├── brave/
│   └── .local/
│       └── share/
│           └── applications/
│               └── brave-private.desktop
├── AGENTS.md
├── README.md
└── .gitignore
```

For example, Stow links
`sway/.config/sway/config` to `~/.config/sway/config`.

The currently managed packages are `sway`, `alacritty`, `rofi`, `shell`, and
`zed`. Likely future packages, created only when their configuration is
reviewed, are:

```text
waybar/    # ~/.config/waybar/
git/       # ~/.gitconfig, if a portable configuration is desired
```

Keeping these independent makes it possible to deploy, review, or remove one
application's configuration without affecting the others.

## Current Baseline

This repository was initialized on Fedora Linux 44 Sway Spin.

- Sway, Alacritty, Rofi, Zed settings, a Brave private-window launcher, and a
  Bash prompt fragment are deployed as separate Stow packages.
- `~/.config/sway/config` is a relative symlink into this repository.
- The Sway file is based on Fedora's main config. Its intentional changes are a
  GB keyboard layout and a user wallpaper path.
- The referenced wallpaper is not tracked. It is local data, so a fresh machine
  must supply that file or later replace the setting with a portable choice.
- Waybar has no user configuration and inherits
  `/etc/xdg/waybar/config.jsonc` and `/etc/xdg/waybar/style.css`.
- Alacritty is the configured terminal. Foot remains installed with no user
  configuration and inherits `/etc/xdg/foot/foot.ini`.
- Alacritty and Rofi use `JetBrainsMono Nerd Font Mono`, installed separately
  as a user-local font because Fedora's JetBrains Mono package is not the
  icon-patched Nerd Font variant.
- The standard Bash startup files currently match `/etc/skel` and are not
  managed.
- Zed's portable `settings.json` is managed. Mutable Zed state and credentials
  remain outside the repository.
- Brave is installed separately from its official Fedora repository. The
  managed `Brave Private` desktop entry always launches it with `--incognito`;
  the browser profile, extensions, and other mutable state remain untracked.
- Other files under `~/.config` currently belong to applications or are
  generated state. In particular, browser profiles, `dconf`, PulseAudio
  cookies, histories, caches, and databases must not be copied into this
  repository.

The repository lives at `~/repos/dotfiles`. Paths are case-sensitive. If it is
relocated again, unstow packages before moving the repository, then restow them
from the new location.

## How Fedora's Sway Configuration Works

Fedora provides the main template at `/etc/sway/config`. The managed user copy
retains Fedora's `layered-include` call, which selects configuration snippets
in this order:

1. `/usr/share/sway/config.d/*.conf` — Fedora Sway defaults such as Waybar,
   idle locking, media/brightness/volume/screenshot bindings, window rules,
   PolicyKit, and XDG autostart.
2. `/etc/sway/config.d/*.conf` — system integration, currently the
   `sway-systemd` session and cgroup snippets.
3. `~/.config/sway/config.d/*.conf` — optional user overrides.

For files with the same name, the later layer wins. This means a small tracked
file such as `sway/.config/sway/config.d/90-bar.conf` can override Fedora's
`90-bar.conf` without copying or editing the system file. No user override
snippets have been added yet.

This layering is deliberately preserved so Fedora integration continues to
receive package updates.

## Dependencies

Required to deploy the repository:

- Fedora Linux (the configuration currently targets Fedora 44 Sway Spin)
- GNU Stow
- Git

Required by the current Sway configuration:

- Sway and Fedora's `sway-config-fedora`
- `sway-systemd`
- Foot
- Waybar
- the utilities required or recommended by Fedora's Sway snippets, normally
  supplied by the Sway Spin

Fedora 44's `rofi` 2.x package includes the native Wayland backend and replaces
the former separately named `rofi-wayland` package.

Check availability without changing the system:

```bash
rpm -q git stow sway sway-config-fedora sway-systemd alacritty rofi waybar
```

Install or system-bootstrap commands are intentionally not automated. Review
and approve system package changes before running them.

## Install on a Fresh Fedora Machine

Choose one path and keep its capitalization consistent. The examples use the
intended `~/repos/dotfiles`:

```bash
mkdir -p "$HOME/repos"
git clone <repository-url> "$HOME/repos/dotfiles"
cd "$HOME/repos/dotfiles"
```

Inspect the destination before deployment:

```bash
find "$HOME/.config/sway" -maxdepth 2 -print 2>/dev/null
stow --no --verbose=2 --target="$HOME" sway
```

If the preview reports a conflict, compare and back up the existing file.
Do not blindly use `stow --adopt`: it imports the destination into the package
and may change tracked files.

Deploy the reviewed package:

```bash
stow --verbose=1 --target="$HOME" sway
```

Supply the locally referenced wallpaper at
`~/Pictures/Wallpapers/wallhaven-vpyekp.jpg`, or review and change the wallpaper
line before starting Sway. Validate from an environment where Sway can access
the graphical session:

```bash
sway --validate --config "$HOME/.config/sway/config"
```

To deploy future packages, name them explicitly:

```bash
stow --no --verbose=2 --target="$HOME" foot waybar
stow --verbose=1 --target="$HOME" foot waybar
```

Explicit package names keep restoration controlled and reviewable.

## Brave Private Browser

Brave itself is not stored in this repository. On Fedora 41 or newer, install
the native package from Brave's official repository:

```bash
sudo dnf config-manager addrepo \
  --from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
sudo dnf install brave-browser
```

Deploy the private-window launcher:

```bash
stow --no --verbose=2 --target="$HOME" brave
stow --verbose=1 --target="$HOME" brave
```

`Brave Private` then appears in the application launcher and always invokes
Brave with `--incognito`. Install Bitwarden from the Chrome Web Store, visit
`brave://extensions`, open Bitwarden's details, and enable **Allow in
Incognito**. Browser profiles, extension data, credentials, and browsing state
remain local and untracked.

## Restore, Update, and Remove

After pulling repository changes, restow a package so Stow can repair or update
its links:

```bash
cd "$HOME/repos/dotfiles"
git pull --ff-only
stow --restow --target="$HOME" sway
```

Remove only a package's managed links:

```bash
stow --delete --target="$HOME" sway
```

Unstowing does not remove Sway or any system configuration. If local files need
to replace the links, unstow first and then restore them from a separate,
private backup.

## Machine-Specific and Private Configuration

Portable defaults belong in tracked Stow packages. Host-specific output names,
docking layouts, device identifiers, and similar values should use a separate,
clearly documented local layer when needed rather than being embedded in the
portable base.

Secrets and mutable application data do not belong here. Never commit private
keys, credentials, tokens, cookies, password databases, shell history, browser
profiles, or files generated at runtime. A `.example` template with placeholders
is preferred when private local configuration needs documentation.

## Change Policy

- Keep changes small and explain why each setting exists.
- Inspect existing user files and Fedora defaults before taking ownership of a
  configuration.
- Preserve Fedora's native Sway, XDG, and systemd-user integration where useful.
- Do not edit `/etc` or `/usr`, install software, or make system-wide changes
  as part of ordinary dotfile work.
- Do not introduce aesthetic changes until they have been reviewed separately.

Contributor and automation rules are recorded in [AGENTS.md](AGENTS.md).
