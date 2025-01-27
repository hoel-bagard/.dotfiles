return {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {

        -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
        skip_confirm_for_simple_edits = false,

        -- Set to true to watch the filesystem for changes and reload oil
        watch_for_changes = true,
        view_options = {
            show_hidden = true,
            -- Sort file names with numbers in a more intuitive order for humans.
            -- Can be "fast", true, or false. "fast" will turn it off for large directories.
            natural_order = "fast",
            -- Sort file and directory names case insensitive
            case_insensitive = false,
            sort = {
                -- sort order can be "asc" or "desc"
                -- see :help oil-columns to see which columns are sortable
                { "type", "asc" },
                { "name", "asc" },
            },
        },

        -- Configuration for the floating window in oil.open_float
        float = {
            -- preview_split: Split direction: "auto", "left", "right", "above", "below".
            preview_split = "right",
        },
    },

    -- Optional dependencies
    dependencies = { "echasnovski/mini.icons", "nvim-tree/nvim-web-devicons" },
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
}
