# Bash completion for archer

_archer() {
    local cur commands
    cur="${COMP_WORDS[COMP_CWORD]}"
    commands="install remove search help version"

    if [[ ${COMP_CWORD} -eq 1 ]]; then
        COMPREPLY=($(compgen -W "$commands" -- "$cur"))
    fi
}

complete -F _archer archer
