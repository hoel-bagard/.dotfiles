if not pcall(require, "neo-tree") then
    return
end

-- Define icons for diagnostic errors.
vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

-- See defaults here: https://github.com/nvim-neo-tree/neo-tree.nvim/blob/main/lua/neo-tree/defaults.lua
require("neo-tree").setup({
    close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,
    sort_case_insensitive = false, -- used when sorting files and directories in the tree

    filesystem = {
        filtered_items = {
            visible = true, -- when true, they will just be displayed differently than normal items
        },
    },
})
