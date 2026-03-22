-- Spelling language tooling
-- LSP: typos_lsp (source code spell checker)

---@type LazyPluginSpec[]
return {
    {
        "neovim/nvim-lspconfig",
        opts = function()
            local capabilities = _G.LspCapabilities and _G.LspCapabilities() or {}
            vim.lsp.config("typos_lsp", {
                capabilities = capabilities,
                init_options = {
                    diagnosticSeverity = "hint",
                    config = vim.env.XDG_CONFIG_HOME .. "/typos/typos.toml",
                },
            })
            vim.lsp.enable("typos_lsp")
        end,
    },
}
