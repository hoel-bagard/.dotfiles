-- C# language configuration
-- LSP: omnisharp

---@type LazyPluginSpec[]
return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = { "c_sharp" },
        },
    },

    {
        "neovim/nvim-lspconfig",
        opts = function()
            local capabilities = _G.LspCapabilities and _G.LspCapabilities() or {}
            vim.lsp.config("omnisharp", {
                capabilities = capabilities,
            })
            vim.lsp.enable("omnisharp")
        end,
    },
}
