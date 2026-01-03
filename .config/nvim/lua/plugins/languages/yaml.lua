-- YAML language configuration
-- LSP: yamlls (yaml-language-server)
--   Provides schema-based autocompletion and validation via SchemaStore
--   Note: GitHub Actions files use a separate LSP (see github-actions.lua)

---@type LazyPluginSpec[]
return {
    {
        "nvim-treesitter/nvim-treesitter",
        ---@type plugins.treesitter.opts
        opts = {
            ensure_installed = { "yaml" },
        },
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = { "b0o/schemastore.nvim" },
        opts = function()
            local capabilities = _G.LspCapabilities and _G.LspCapabilities() or {}
            vim.lsp.config("yamlls", {
                capabilities = capabilities,
                settings = {
                    yaml = {
                        schemaStore = {
                            -- Disable built-in schemaStore to use schemastore.nvim
                            enable = false,
                            -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                            url = "",
                        },
                        schemas = require("schemastore").yaml.schemas(),
                        -- Do not format through the LSP, leave it to conform.
                        format = {
                            enable = false,
                        },
                        validate = true,
                    },
                },
            })
            vim.lsp.enable("yamlls")
        end,
    },

    {
        "stevearc/conform.nvim",
        ---@type conform.setupOpts
        opts = {
            formatters_by_ft = {
                yaml = { "yamlfmt" },
            },
        },
    },
}
