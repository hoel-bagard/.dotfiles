# On Arch Linux, in case of a command not found error, try to find the package providing the command.
$env.config.hooks.command_not_found = $env.config.hooks.command_not_found | append {
    |cmd_name| (
        try {
            let pkgs = (pkgfile --binaries --verbose $cmd_name);
            if ($pkgs | is-empty) {
                return null
            }
            return $"(ansi $env.config.color_config.shape_external)($cmd_name)(ansi reset) may be found in the following packages:\n($pkgs)"
        }
    )
}

