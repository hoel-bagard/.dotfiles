---@type LazyPluginSpec
return {
    "nvim-neo-tree/neo-tree.nvim",
    -- branch = "v3.x",
    branch = "main",
    opts = {
        window = {
            mappings = {
                ["P"] = {
                    "toggle_preview",
                    config = {
                        use_float = false,
                        use_image_nvim = true,
                        -- title = 'Neo-tree Preview',
                    },
                },
            },
        },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        { "3rd/image.nvim", opts = {} }, -- Optional image support in preview window.
    },
    cmd = "Neotree",
}
