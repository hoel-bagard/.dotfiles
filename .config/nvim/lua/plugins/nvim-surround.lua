---@type LazyPluginSpec
return {
    "kylechui/nvim-surround",
    version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    opts = {

        keymaps = {
            visual = "<leader>S",
        },
    },

    config = function(_, opts)
        require("nvim-surround").setup({ opts })
    end,
}
