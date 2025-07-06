use std/util "path add"

$env.config.show_banner = false
$env.config.buffer_editor = "nvim"

path add ($env.HOME | path join ".local/bin")
path add ($env.HOME | path join ".cargo/bin")

