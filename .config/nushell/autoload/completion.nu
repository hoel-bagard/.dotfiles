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

