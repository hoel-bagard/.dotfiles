use std/util "path add"

$env.config.show_banner = false
$env.config.buffer_editor = "nvim"

$env.config.edit_mode = "vi"
# Disable prompt from Nushell, since we're using Starship's prompt.
$env.PROMPT_INDICATOR_VI_NORMAL = ""
$env.PROMPT_INDICATOR_VI_INSERT = ""
# Use cursor shapes to differentiate.
$env.config.cursor_shape.vi_insert = "line"
$env.config.cursor_shape.vi_normal = "block"

path add ($env.HOME | path join ".local/bin")
path add ($env.HOME | path join ".cargo/bin")
