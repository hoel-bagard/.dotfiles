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

# Automatically enter and exit python virtual environments.
$env.config = ($env.config | upsert hooks.env_change.PWD {
    [
        {
            condition: {|_, after|
                $after | path join .venv | path exists
            }
            code: "overlay use .venv/bin/activate.nu"
        }
        {
            condition: {|before, after|
                (($before | default "") not-in $after and "activate" in (overlay list))
            }
            code: "overlay hide activate  --keep-env [ PWD ]"
        }
    ]
})

# Make direnv work the way it does with other shells.
$env.config.hooks.pre_prompt = $env.config.hooks.pre_prompt | append {
    | |
        if (which direnv | is-empty) {
            return
        }

        direnv export json | from json | default {} | load-env
        if 'ENV_CONVERSIONS' in $env and 'PATH' in $env.ENV_CONVERSIONS {
            $env.PATH = do $env.ENV_CONVERSIONS.PATH.from_string $env.PATH
        }
}
