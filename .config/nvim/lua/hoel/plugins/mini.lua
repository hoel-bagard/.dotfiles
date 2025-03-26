-- Collection of various small independent plugins/modules
return {
    -- Simple and easy statusline.
    {
        "echasnovski/mini.statusline",
        version = "*",
        opts = {
            -- set use_icons to true if Nerd Font is available.
            use_icons = vim.g.have_nerd_font,
        },
        config = function(_, opts)
            local statusline = require("mini.statusline")
            statusline.setup(opts)

            -- Set the section for cursor location to LINE:COLUMN
            ---@diagnostic disable-next-line: duplicate-set-field
            statusline.section_location = function()
                return "%2l:%-2v"
            end
        end,
    },

    {
        "echasnovski/mini.trailspace",
        version = "*",
        lazy = false,
        keys = {
            {
                "<Leader>tw",
                "<Cmd>lua MiniTrailspace.trim()<CR>",
                desc = "[T]rim [W]hitespaces",
                silent = true,
            },
            {
                "<Leader>tl",
                "<Cmd>lua MiniTrailspace.trim_last_lines()<CR>",
                desc = "[T]rim [L]astlines",
                silent = true,
            },
        },
        opts = {},

        config = function(_, opts)
            require("mini.trailspace").setup(opts)

            -- To prevent mini.trailspace from interfering with the snacks.nvim dashboard,
            -- disable it by default and re-enable it when opening a buffer.
            -- See: https://github.com/echasnovski/mini.nvim/issues/1395
            vim.g.minitrailspace_disable = true
            vim.api.nvim_create_autocmd("VimEnter", {
                callback = function()
                    vim.g.minitrailspace_disable = false
                end,
            })

            -- The following is an attempt to do the same thing as above in a more "proper" way,
            -- however it creates a flash on start, I tried other similar ways of doing it, without success.
            -- require("mini.trailspace").setup()
            -- vim.api.nvim_create_autocmd("User", {
            --     pattern = "SnacksDashboardOpened",
            --     callback = function(args)
            --         vim.b[args.buf].minitrailspace_disable = true
            --     end,
            -- })
        end,
    },

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    { "echasnovski/mini.surround", version = "*" },

    -- Better Around/Inside textobjects
    -- Example:
    --  - yinq - [Y]ank [I]nside [N]ext [']quote
    {
        "echasnovski/mini.ai",
        version = "*",
        opts = {
            -- Number of lines within which textobject is searched.
            n_lines = 100,
        },
    },
}
