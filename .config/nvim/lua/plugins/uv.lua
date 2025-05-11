return {
    "benomahony/uv.nvim",
    opts = {
        -- Auto-activate virtual environments when found
        auto_activate_venv = true,

        -- Auto commands for directory changes
        auto_commands = true,

        -- Integration with snacks picker
        picker_integration = true,

        keymaps = {
            prefix = "<leader>u", -- Main prefix for uv commands
            commands = true, -- Show uv commands menu (<leader>u)
            run_file = true, -- Run current file (<leader>ur)
            run_selection = true, -- Run selected code (<leader>us)
            run_function = true, -- Run function (<leader>uf)
            venv = true, -- Environment management (<leader>ue) spellchecker:disable-line
            init = true, -- Initialize uv project (<leader>ui)
            add = true, -- Add a package (<leader>ua)
            remove = true, -- Remove a package (<leader>ud)
            sync = true, -- Sync packages (<leader>uc)
        },

        -- Execution options
        execution = {
            -- Python run command template
            run_command = "uv run python",
            -- Show output in notifications
            notify_output = true,
            -- Notification timeout in ms
            notification_timeout = 10000,
        },
    },
}
