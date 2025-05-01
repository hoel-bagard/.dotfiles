return {
    "ray-x/lsp_signature.nvim",

    -- event = "InsertEnter",
    opts = {
        bind = true,
        handler_opts = {
            border = "rounded",
        },
    },

    config = function()
        -- require("lspconfig").gopls.setup()
        require("lsp_signature").setup({
            bind = true,
            handler_opts = {
                border = "rounded",
            },
        })
    end,
}
