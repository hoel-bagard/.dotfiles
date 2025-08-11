$env.STARSHIP_CONFIG = ($env.HOME | path join ".config/starship/starship.toml")

# Set up starship if needed.
if not ($nu.data-dir | path join "vendor/autoload/starship.nu" | path exists) {
    mkdir ($nu.data-dir | path join "vendor/autoload")
    starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
}

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

# Keep the right prompt after executing a command.
$env.TRANSIENT_PROMPT_COMMAND_RIGHT = { || starship prompt --right --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)' }

# Fix the right prompt appearing one line above the left prompt. c.f. https://github.com/starship/starship/issues/6473
$env.config.render_right_prompt_on_last_line = true
