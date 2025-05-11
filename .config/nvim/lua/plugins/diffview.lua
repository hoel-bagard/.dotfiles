return {
    "sindrets/diffview.nvim",
    keys = {
        {
            "<leader>gD",
            function()
                vim.cmd("DiffviewOpen master..HEAD")
            end,
            desc = "[G]it [D]iff master",
        },
    },
    opts = {
        keymaps = {
            view = {
                { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diff view" } },
            },
            file_panel = {
                { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diff view" } },
            },
            file_history_panel = {
                { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diff view" } },
            },
        },
    },
}
