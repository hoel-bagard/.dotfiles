return {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,

    -- Only want to load obsidian.nvim for markdown files in the vault.
    event = {
        "BufReadPre " .. vim.fn.expand("~") .. "/work/notes/*.md",
        "BufNewFile  " .. vim.fn.expand("~") .. "/work/notes/*.md",
        "VimEnter",
    },

    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
        "nvim-treesitter/nvim-treesitter",
    },
    opts = {
        workspaces = {
            {
                name = "personal",
                path = "~/work/notes",
            },
            -- {
            --     name = "HHT",
            --     path = "~/work-hitachi/notes",
            -- },
        },

        daily_notes = {
            folder = "dailies",
            date_format = "%Y-%m-%d-%A",
            alias_format = "%B %-d, %Y",
            default_tags = { "daily-notes" },
            template = "daily.md",
        },

        completion = {
            -- Set to false to disable completion.
            nvim_cmp = true,
            -- Trigger completion at 2 chars.
            min_chars = 2,
        },

        mappings = {},

        -- Either 'wiki' or 'markdown'.
        preferred_link_style = "markdown",

        disable_frontmatter = function(fname)
            return vim.g.obsidian_frontmatter_disabled or false
        end,

        templates = {
            subdir = "templates",
            date_format = "%Y-%m-%d",
            time_format = "%H:%M",
        },

        ui = { enable = false },
    },
}
