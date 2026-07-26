# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# Start Sway automatically after logging in on the first virtual console.
if [[ -z ${DISPLAY:-} &&
      -z ${WAYLAND_DISPLAY:-} &&
      ${XDG_VTNR:-0} -eq 1 ]]; then
    exec start-sway
fi
