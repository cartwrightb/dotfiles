# Repository Guide

## Purpose

This repository is the single source of truth for portable user configuration
on Fedora Sway systems. GNU Stow deploys files into the user's home directory.
Keep the result small, understandable, and reproducible.

## Architecture

- Each top-level application directory is one independent Stow package.
- A package's contents mirror paths below `$HOME`.
- XDG configuration normally lives at
  `<package>/.config/<application>/...`.
- Home-directory files such as `.bashrc` belong at the root of their package.
- Repository documentation and metadata (`README.md`, `AGENTS.md`,
  `.gitignore`) are not Stow packages.
- Current packages are `sway`, `alacritty`, `rofi`, and `shell`.
- Add a package only when there is real user configuration to manage. Do not
  create placeholder package directories.

Example:

```text
foot/
└── .config/
    └── foot/
        └── foot.ini
```

Deploy that package from the repository root with:

```bash
stow --target="$HOME" foot
```

## Fedora and Sway Integration

- Preserve useful Fedora defaults instead of copying them wholesale.
- The Sway main config retains Fedora's layered include mechanism. Its order is
  `/usr/share/sway/config.d`, `/etc/sway/config.d`, then the user's
  `~/.config/sway/config.d`.
- Prefer a small same-named file under
  `sway/.config/sway/config.d/` when overriding a Fedora snippet. The user
  layer takes precedence.
- Treat `/usr/share` and `/etc` as upstream/system state. Inspect them to
  understand behavior, but do not modify them without explicit user approval.
- Keep hardware-specific output and input details out of shared configuration
  when they are not portable. If such configuration becomes necessary, place
  it in an explicitly documented local or host-specific layer.
- Before changing Sway configuration, compare it with `/etc/sway/config` and
  inspect the active snippets in `/usr/share/sway/config.d` and
  `/etc/sway/config.d`.

## Change Rules

- Make small, reviewable changes and explain significant architectural
  decisions.
- Do not redesign appearance, key bindings, or application behavior unless the
  task explicitly calls for it.
- Prefer native Fedora, freedesktop.org, XDG, systemd-user, and Sway mechanisms
  over extra frameworks or bootstrap tooling.
- Do not install packages or make system-wide changes without discussing them
  with the user first.
- Never edit system-owned files under `/etc` or `/usr` without a clear reason
  and explicit approval.
- Do not absorb generated state, caches, history, browser profiles, databases,
  or application runtime files into Stow packages.
- Never commit secrets, credentials, tokens, cookies, private keys, or
  machine-issued identity files.
- Keep machine-specific and private values outside tracked packages. Commit a
  documented example file when a template is useful.
- Do not copy large third-party dotfile sets. Add only settings that have a
  known purpose.
- Preserve unrelated user changes in both the repository and `$HOME`.

## Safe Workflow

Before adding or changing a package:

1. Inspect the existing destination and determine whether it is user-authored,
   generated, a symlink, or inherited from an XDG/system default.
2. Check package and application documentation for the native override
   mechanism.
3. Move only intentional configuration into the package.
4. Preview deployment:

   ```bash
   stow --no --verbose=2 --target="$HOME" <package>
   ```

5. Resolve conflicts explicitly. Do not use `--adopt` casually because it can
   overwrite repository files with destination contents.
6. Deploy and verify:

   ```bash
   stow --verbose=1 --target="$HOME" <package>
   ```

When removing a package's links:

```bash
stow --delete --target="$HOME" <package>
```

Unstowing removes managed symlinks; it does not uninstall the application.

## Validation

- Run `git diff --check` and inspect `git diff` before handing off changes.
- Use `stow --no --verbose=2 --target="$HOME" <package>` to check link plans.
- Use application-native validation where available.
- For Sway, use `sway --validate --config
  "$HOME/.config/sway/config"` from a suitable graphical session, then reload
  only when the user has requested an active configuration change.
- Document any validation that could not run and why.
