-- Treesitter
-- Plugin specification for nvim-treesitter.
-- Language-specific parsers are added via opts merging from lua/plugins/languages/*.lua

---@class plugins.treesitter.opts
---@field ensure_installed? string[]

---@type LazyPluginSpec
return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter",
    ---@type plugins.treesitter.opts
    opts = {
        sync_install = false,
        auto_install = true,

        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<M-w>", -- maps in normal mode to init the node/scope selection
                node_incremental = "<M-w>", -- increment to the upper named parent
                node_decremental = "<M-C-w>", -- decrement to the previous node
                scope_incremental = "<M-e>", -- increment to the upper scope (as defined in locals.scm)
            },
        },

        textobjects = {
            select = {
                enable = true,
                -- Automatically jump forward to textobj, similar to targets.vim
                lookahead = true,

                keymaps = {
                    -- You can use the capture groups defined in textobjects.scm
                    ["af"] = { query = "@function.outer", desc = "Select [a]round [f]unction" },
                    ["if"] = { query = "@function.inner", desc = "Select [i]nner [f]unction" },
                    ["ac"] = { query = "@class.outer", desc = "Select [a]round [c]lass" },
                    ["ic"] = { query = "@class.inner", desc = "Select [i]nner [c]lass" },
                    ["as"] = {
                        query = "@local.scope",
                        query_group = "locals",
                        desc = "Select [a]round language [s]cope",
                    },
                },
            },
        },
    },

    config = function(_, opts)
        vim.api.nvim_create_autocmd("FileType", {
            callback = function()
                -- Enable treesitter highlighting and disable regex syntax
                pcall(vim.treesitter.start)
                -- Enable treesitter-based indentation
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })

        local ensureInstalled = {
            -- Base parsers (non-language-specific)
            "vim",
            "vimdoc",
            "lua",
            "python",
            "rust",
        }
        local alreadyInstalled = require("nvim-treesitter.config").get_installed()
        local parsersToInstall = vim.iter(ensureInstalled)
            :filter(function(parser)
                return not vim.tbl_contains(alreadyInstalled, parser)
            end)
            :totable()
        require("nvim-treesitter").install(parsersToInstall)
    end,
}
