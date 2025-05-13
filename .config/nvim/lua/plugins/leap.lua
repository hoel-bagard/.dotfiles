---@type LazyPluginSpec
return {
    "ggandor/leap.nvim",
    lazy = false,
    config = function()
        -- vim.keymap.set("n", "s", "<Plug>(leap-anywhere)")
        vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
        vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")
        vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-from-window)")
    end,
    opts = {
        -- Define equivalence classes for brackets and quotes, in addition to the default whitespace group:
        equivalence_classes = { " \t\r\n", "([{", ")]}", "'\"`" },
    },
}
