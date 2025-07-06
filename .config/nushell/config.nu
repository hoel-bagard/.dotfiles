mkdir ($nu.data-dir | path join "vendor/autoload")

$env.config.buffer_editor = "nvim"
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
