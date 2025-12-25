---@type LazyPluginSpec
return {
    "NickvanDyke/opencode.nvim",
    dependencies = {
        "folke/snacks.nvim",
    },
    config = function()
        ---@type opencode.Opts
        vim.g.opencode_opts = {
            provider = { enabled = "terminal" }, -- Stay within neovim, do not open a Wezterm pane.
        }

        -- Required for `opts.events.reload`.
        vim.o.autoread = true
    end,
}
