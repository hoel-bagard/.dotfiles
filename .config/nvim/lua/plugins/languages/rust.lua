-- Rust language configuration
-- LSP: rust_analyzer with clippy integration

---@type LazyPluginSpec[]
return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = { "rust", "ron" },
        },
    },

    {
        "neovim/nvim-lspconfig",
        opts = function()
            local capabilities = _G.LspCapabilities and _G.LspCapabilities() or {}
            vim.lsp.config("rust_analyzer", {
                capabilities = capabilities,
                settings = {
                    ["rust-analyzer"] = {
                        check = {
                            allFeatures = true,
                            command = "clippy",
                            extraArgs = {
                                "--",
                                "--no-deps",
                                "-Wclippy::pedantic",
                                "-Wclippy::nursery",
                                -- "-Wclippy::unwrap_used",
                                -- "-Wclippy::expect_used",
                                "-Aclippy::cast_precision_loss",
                                "-Adead_code",
                            },
                        },
                        diagnostics = {
                            disabled = { "inactive-code" },
                        },
                        cargo = {
                            allFeatures = true,
                        },
                    },
                },
            })
            vim.lsp.enable("rust_analyzer")
        end,
    },

    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                rust = { "rustfmt", "dioxus_fmt" },
            },
            formatters = {
                dioxus_fmt = {
                    command = "dx",
                    args = { "fmt", "--file", "$FILENAME" },
                    stdin = false,
                },
            },
        },
    },
}
