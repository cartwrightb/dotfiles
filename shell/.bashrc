# Keep Fedora's system-wide Bash defaults.
if [[ -r /etc/bashrc ]]; then
    source /etc/bashrc
fi

# Put user-installed commands ahead of system paths.
case ":${PATH}:" in
    *:"${HOME}/.local/bin":"${HOME}/bin":*) ;;
    *) PATH="${HOME}/.local/bin:${HOME}/bin:${PATH}" ;;
esac
export PATH

# Load small, purpose-specific shell fragments.
if [[ -d ${HOME}/.bashrc.d ]]; then
    for bashrc_fragment in "${HOME}"/.bashrc.d/*.sh; do
        [[ -r ${bashrc_fragment} ]] && source "${bashrc_fragment}"
    done
    unset bashrc_fragment
fi

# Keep host-specific or private configuration outside the repository.
if [[ -r ${HOME}/.bashrc.local ]]; then
    source "${HOME}/.bashrc.local"
fi
