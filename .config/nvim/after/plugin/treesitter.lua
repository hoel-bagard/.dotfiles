if not pcall(require, "nvim-treesitter") then
    return
end

---@diagnostic disable-next-line: missing-fields
require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "bash",
        "css",
        -- "dockerfile",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "python",
        "rust",
        "toml",
        "typescript",
        "vim",
        "vimdoc",
        "graphql",
        "just",
    },
    sync_install = false,
    auto_install = true,

    highlight = { enable = true },

    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<M-w>", -- maps in normal mode to init the node/scope selection
            node_incremental = "<M-w>", -- increment to the upper named parent
            node_decremental = "<M-C-w>", -- decrement to the previous node
            scope_incremental = "<M-e>", -- increment to the upper scope (as defined in locals.scm)
        },
    },

    indent = { enable = false },

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
                ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select [a]round language [s]cope" },
            },
        },
    },
})
