# Fish completion for pacmenu

complete -c pacmenu -f
complete -c pacmenu -n '__fish_use_subcommand' -a install -d 'Install packages (official repos + AUR)'
complete -c pacmenu -n '__fish_use_subcommand' -a remove -d 'Remove installed packages'
complete -c pacmenu -n '__fish_use_subcommand' -a search -d 'Browse installed packages'
complete -c pacmenu -n '__fish_use_subcommand' -a help -d 'Show help information'
complete -c pacmenu -n '__fish_use_subcommand' -a version -d 'Show version'
complete -c pacmenu -n '__fish_use_subcommand' -l help -d 'Show help'
complete -c pacmenu -n '__fish_use_subcommand' -l version -d 'Show version'
