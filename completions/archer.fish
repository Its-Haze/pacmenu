# Fish completion for archer

complete -c archer -f
complete -c archer -n '__fish_use_subcommand' -a install -d 'Install packages (official repos + AUR)'
complete -c archer -n '__fish_use_subcommand' -a remove -d 'Remove installed packages'
complete -c archer -n '__fish_use_subcommand' -a search -d 'Browse installed packages'
complete -c archer -n '__fish_use_subcommand' -a help -d 'Show help information'
complete -c archer -n '__fish_use_subcommand' -a version -d 'Show version'
complete -c archer -n '__fish_use_subcommand' -l help -d 'Show help'
complete -c archer -n '__fish_use_subcommand' -l version -d 'Show version'
