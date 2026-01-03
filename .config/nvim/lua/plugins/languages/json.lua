-- JSON language configuration
-- LSP: jsonls (vscode-json-languageserver)
--   Provides schema-based autocompletion and validation via SchemaStore

---@module "conform"

---@type LazyPluginSpec[]
return {
    {
        "nvim-treesitter/nvim-treesitter",
        ---@type plugins.treesitter.opts
        opts = {
            ensure_installed = { "json", "jsonc" },
        },
    },

    -- A collection of JSON schema files including full API
    { "b0o/schemastore.nvim", lazy = true },

    {
        "neovim/nvim-lspconfig",
        dependencies = { "b0o/schemastore.nvim" },
        opts = function()
            --Enable (broadcasting) snippet capability for completion
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true

            vim.lsp.config("jsonls", {
                capabilities = capabilities,
                settings = {
                    json = {
                        schemas = require("schemastore").json.schemas(),
                        validate = { enable = true },
                    },
                },
            })
            vim.lsp.enable("jsonls")
        end,
    },

    {
        "stevearc/conform.nvim",
        ---@type conform.setupOpts
        opts = {
            formatters_by_ft = {
                json = { "prettier" },
                jsonc = { "prettier" },
            },
        },
    },

    {
        "mfussenegger/nvim-lint",
        ---@type plugins.lint.opts
        opts = {
            linters_by_ft = {
                json = { "jsonlint" },
            },
        },
    },
}
