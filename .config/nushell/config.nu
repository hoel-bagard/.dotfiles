use std/util "path add"

$env.config.show_banner = false
$env.config.buffer_editor = "nvim"
$env.config.history.max_size = 1000

$env.config.edit_mode = "vi"
# Disable prompt from Nushell, since we're using Starship's prompt.
$env.PROMPT_INDICATOR_VI_NORMAL = ""
$env.PROMPT_INDICATOR_VI_INSERT = ""
# Use cursor shapes to differentiate.
$env.config.cursor_shape.vi_insert = "line"
$env.config.cursor_shape.vi_normal = "block"

path add ($env.HOME | path join ".local/bin")
path add ($env.HOME | path join ".cargo/bin")
# On Arch Linux, try to find the package providing the command.
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

