# Add Git branch and working-tree state to the Bash prompt.
[[ $- == *i* ]] || return 0

if [[ -r /usr/share/git-core/contrib/completion/git-prompt.sh ]]; then
    source /usr/share/git-core/contrib/completion/git-prompt.sh

    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWSTASHSTATE=1
    GIT_PS1_SHOWUNTRACKEDFILES=1
    GIT_PS1_SHOWUPSTREAM=auto

    # Extend Fedora's native coloured prompt instead of replacing it.
    prompt_default_setup
    PROMPT_GIT_BRANCH='$(__git_ps1 "%s")'
    prompt_git_color 36
    prompt_setup_color_ps1
fi
