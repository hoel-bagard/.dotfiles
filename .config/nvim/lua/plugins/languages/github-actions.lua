-- GitHub Actions language configuration
--
-- LSP: actions-languageserver
--   Requires: npm install -g @actions/languageserver
--   Provides:
--     - Workflow syntax validation
--     - Autocompletion for actions, inputs, and expressions
--
-- Linter: actionlint (https://github.com/rhysd/actionlint)
--   Provides deeper validation than the LSP:
--     - Type checking for ${{ }} expressions
--     - Validates action inputs/outputs against actual action definitions
--     - Detects deprecated workflow syntax
--     - Shell script validation (shellcheck integration)
--     - Validates matrix configurations
--     - Detects unreachable code in conditionals
--
-- NOTE: The LSP supports sessionToken and repos init_options for secrets/variables
-- autocompletion, but there's an upstream bug where API errors (403) cause the LSP
-- to write raw HTTP responses to stdout, breaking the JSON-RPC protocol.
-- See: https://github.com/actions/languageservices/tree/main/languageserver#in-neovim

---@type LazyPluginSpec[]
return {
    {
        "neovim/nvim-lspconfig",
        opts = function()
            -- Register filetype for GitHub Actions workflow files
            -- This allows separate LSP config from regular YAML files
            vim.filetype.add({
                pattern = {
                    [".*/%.github/workflows/.*%.ya?ml"] = "yaml.ghactions",
                },
            })

            local capabilities = _G.LspCapabilities and _G.LspCapabilities() or {}
            vim.lsp.config("actions_ls", {
                cmd = { "actions-languageserver", "--stdio" },
                filetypes = { "yaml.ghactions" },
                root_markers = { ".git" },
                capabilities = capabilities,
                -- NOTE: sessionToken/repos intentionally omitted to avoid upstream bug where API errors break LSP. Core features still work without them.
                init_options = {},
            })
            vim.lsp.enable("actions_ls")
        end,
    },

    {
        "mfussenegger/nvim-lint",
        opts = {
            linters_by_ft = {
                ["yaml.ghactions"] = { "actionlint" },
            },
        },
    },
}
