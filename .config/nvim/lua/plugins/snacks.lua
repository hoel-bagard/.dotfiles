---@type LazyPluginSpec
return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },

        dashboard = {
            sections = {
                { section = "header" },
                {
                    pane = 2,
                    section = "terminal",
                    cmd = "colorscript -e square",
                    height = 5,
                    padding = 1,
                },
                { section = "keys", gap = 1, padding = 1 },
                { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
                { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
                {
                    pane = 2,
                    icon = " ",
                    title = "Git Status",
                    section = "terminal",
                    enabled = function()
                        return snacks.git.get_root() ~= nil
                    end,
                    cmd = "git status --short --branch --renames",
                    height = 5,
                    padding = 1,
                    ttl = 5 * 60,
                    indent = 3,
                },
                { section = "startup" },
            },
        },

        picker = { enabled = true },
        input = { enabled = true },
        notifier = { enabled = true },
        indent = { enabled = true, animate = { enabled = false } },
        quickfile = { enabled = true },
        git = { enabled = true },
        gitbrowse = { enabled = true },
    },

    -- stylua: ignore
    keys = {
        -- Top Pickers & Explorer
        { "<leader>ch", function() snacks.picker.command_history() end, desc = "[C]ommand [H]istory" },
        { "<leader>n", function() snacks.picker.notifications() end, desc = "Notification History" },
    },
}
