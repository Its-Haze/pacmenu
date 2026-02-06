# Bash completion for pacmenu

_pacmenu() {
    local cur commands
    cur="${COMP_WORDS[COMP_CWORD]}"
    commands="install remove search help version"

    if [[ ${COMP_CWORD} -eq 1 ]]; then
        COMPREPLY=($(compgen -W "$commands" -- "$cur"))
    fi
}

complete -F _pacmenu pacmenu
