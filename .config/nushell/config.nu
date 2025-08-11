use std/util "path add"

zoxide init nushell --cmd cd | save -f ~/.config/zoxide.nu
source ~/.config/zoxide.nu

$env.config.show_banner = false
$env.config.buffer_editor = "nvim"
$env.config.history.max_size = 1000
$env.config.edit_mode = "vi"

# To sign commits with git
$env.GPG_TTY = (tty)

# Disable prompt from Nushell, since we're using Starship's prompt.
$env.PROMPT_INDICATOR_VI_NORMAL = ""
$env.PROMPT_INDICATOR_VI_INSERT = ""
# Use cursor shapes to differentiate.
$env.config.cursor_shape.vi_insert = "line"
$env.config.cursor_shape.vi_normal = "block"
# When activating a python virtualenv, prevent it from being showed in the prompt, since we're already doing it with Starship.
# cf: https://github.com/pypa/virtualenv/blob/78ebc61f8f30ff3ab2e175418ac69fe112002ff5/src/virtualenv/activation/nushell/activate.nu#L68
$env.VIRTUAL_ENV_DISABLE_PROMPT = true

# Set env variables / PATH
$env.XDG_CONFIG_HOME = $env.HOME | path join ".config"
$env.XDG_STATE_HOME = $env.HOME | path join ".local/state"
$env.XDG_DATA_HOME = $env.HOME | path join ".local/share"
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

# Enable carapace external completions:
let carapace_completer = {|spans|
    carapace $spans.0 nushell ...$spans | from json
}
$env.config.completions.external = {
    enable: true
    max_results: 100
    completer: $carapace_completer
}
$env.config.menus ++= [{
    name: completion_menu
    only_buffer_difference: false # Search is done on the text written after activating the menu
    marker: ""
    type: {
        layout: columnar
        columns: 10
    }
    style: {
        text: white
        selected_text: { bg: "#303030" attr: b }
    }
}]


# Set NU_OVERLAYS with overlay list, so that it can be used in the starship prompt.
# Do not add the python venv to it, since it's handled separately.
$env.config.hooks.pre_prompt = ($env.config.hooks.pre_prompt | append {||
    let overlays  = overlay list | slice 1.. | where $it != activate
    if not ($overlays | is-empty) {
        $env.NU_OVERLAYS = $overlays | str join ", "
    } else {
        $env.NU_OVERLAYS = null
    }
})
