---@type LazyPluginSpec
return {
    "3rd/image.nvim",
    opts = {
        integrations = {
            markdown = {
                enabled = true,
                only_render_image_at_cursor = true,
            },
        },
    },
}
