-- CSS language configuration
-- LSP: tailwindcss

---@type LazyPluginSpec[]
return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = { "css" },
        },
    },

    {
        "neovim/nvim-lspconfig",
        opts = function()
            local capabilities = _G.LspCapabilities and _G.LspCapabilities() or {}
            vim.lsp.config("tailwindcss", {
                capabilities = capabilities,
                filetypes = { "html", "css", "javascript", "typescript", "rust" },
                root_dir = function()
                    return vim.fs.root(0, { "tailwind.css", "tailwind.config.js" })
                end,
                init_options = {
                    userLanguages = {
                        rust = "html",
                    },
                },
                settings = {
                    tailwindCSS = {
                        includeLanguages = {
                            rust = "html",
                        },
                        experimental = {
                            classRegex = {
                                [[class:\s*"([^"]*)"]],
                                [[class:\s*'([^']*)']],
                                [[class\s*=\s*"([^"]*)"]],
                                [[class\s*=\s*'([^']*)']],
                            },
                        },
                    },
                },
            })
            vim.lsp.enable("tailwindcss")
        end,
    },

    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                css = { "rustywind", "prettier" },
            },
        },
    },
}
