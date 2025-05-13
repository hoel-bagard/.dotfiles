return {
    "sindrets/diffview.nvim",
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
