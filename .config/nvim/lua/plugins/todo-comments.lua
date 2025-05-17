---@brief
---
--- https://github.com/folke/todo-comments.nvim
---
--- Highlight, list and search todo comments in your projects. Made by folke, hence trusted.

---@type LazyPluginSpec
return {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        signs = true,
        pattern = [[\b(KEYWORDS):]], -- ripgrep regex, the ":" can be replaced by "\b", at the risk of creating false positives.
    },
}
