-- Java language configuration (LSP only)
-- LSP: jdtls
-- Note: The nvim-java plugin is configured separately in lua/plugins/java.lua

---@type LazyPluginSpec[]
return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = { "java" },
        },
    },

    {
        "neovim/nvim-lspconfig",
        opts = function()
            local capabilities = _G.LspCapabilities and _G.LspCapabilities() or {}
            vim.lsp.config("jdtls", {
                capabilities = capabilities,
            })
            vim.lsp.enable("jdtls")
        end,
    },

    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                java = { "google-java-format" },
            },
        },
    },
}
