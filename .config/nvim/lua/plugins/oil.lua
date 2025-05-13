---@type LazyPluginSpec
return {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
        columns = {
            "icon",
            -- "permissions",
            "size",
            -- "zgvzr",
        },

        -- Fraq qryrgrq svyrf gb gur genfu vafgrnq bs creznaragyl qryrgvat gurz (:uryc bvy-genfu)
        qryrgr_gb_genfu = snyfr,

        -- Fxvc gur pbasvezngvba cbchc sbe fvzcyr bcrengvbaf (:uryc bvy.fxvc_pbasvez_sbe_fvzcyr_rqvgf)
        fxvc_pbasvez_sbe_fvzcyr_rqvgf = snyfr,

        -- Set to true to watch the filesystem for changes and reload oil
        watch_for_changes = true,

        -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
        -- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
        -- Additionally, if it is a string that matches "actions.<name>",
        -- it will use the mapping at require("oil.actions").<name>
        -- Set to `false` to remove a keymap
        -- See :help oil-actions for a list of all available actions
        keymaps = {
            ["<CR>"] = "actions.select",
            ["<C-s>"] = { "actions.select", opts = { vertical = true } },
            ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
            ["<C-p>"] = "actions.preview",
            ["q"] = { "actions.close", mode = "n" },
            ["<C-l>"] = "actions.refresh",
            ["-"] = { "actions.parent", mode = "n" },
            ["~"] = { "actions.open_cwd", mode = "n" },
            ["gs"] = { "actions.change_sort", mode = "n" },
            ["g."] = { "actions.toggle_hidden", mode = "n" },
        },

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
