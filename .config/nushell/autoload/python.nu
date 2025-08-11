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
