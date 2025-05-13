---@type LazyPluginSpec
return {
    "ray-x/lsp_signature.nvim",

    opts = {
        bind = true,
        handler_opts = {
            border = "rounded",
        },
    },

    config = function(_, opts)
        require("lsp_signature").setup(opts)

        -- require("lspconfig").gopls.setup()
        require("lsp_signature").setup({
            bind = true,
            handler_opts = {
                border = "rounded",
            },
        })
    end,
}
