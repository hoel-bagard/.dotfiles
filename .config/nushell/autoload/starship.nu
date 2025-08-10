$env.STARSHIP_CONFIG = ($env.HOME | path join ".config/starship/starship.toml")

# Set up starship if needed.
if not ($nu.data-dir | path join "vendor/autoload/starship.nu" | path exists) {
    mkdir ($nu.data-dir | path join "vendor/autoload")
    starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
}

# Keep the right prompt after executing a command.
$env.TRANSIENT_PROMPT_COMMAND_RIGHT = { || starship prompt --right --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)' }

# Fix the right prompt appearing one line above the left prompt. c.f. https://github.com/starship/starship/issues/6473
$env.config.render_right_prompt_on_last_line = true
