mkdir ($nu.data-dir | path join "vendor/autoload")

$env.config.buffer_editor = "nvim"

# Starship config
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
# Keep the right prompt after executing a command.
$env.TRANSIENT_PROMPT_COMMAND_RIGHT = { || starship prompt --right }
# Fix the right prompt appearing one line above the left prompt. c.f. https://github.com/starship/starship/issues/6473
$env.config.render_right_prompt_on_last_line = true
