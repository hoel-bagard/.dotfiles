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
path add ($env.HOME | path join ".local/bin/scripts")
path add ($env.HOME | path join ".cargo/bin")

# Source XC aliases if on home PC.
use (if ("~/.config/xc-dotfiles/aliases.nu" | path exists) {
    '~/.config/xc-dotfiles/aliases.nu'
} else {
    '~/.config/nushell/env.nu'  # Does nothing
}) *
