---@type LazyPluginSpec
return {
    "numToStr/Comment.nvim",
    ---@type CommentConfig
    ---@diagnostic disable: missing-fields
    opts = {
        -- ignores empty lines
        ignore = "^$",
    },
    lazy = false,
}
