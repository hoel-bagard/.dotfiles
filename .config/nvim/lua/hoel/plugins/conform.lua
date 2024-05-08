-- Autoformat
return {
    "stevearc/conform.nvim",
    lazy = false,
    opts = {
        notify_on_error = true,
        format_on_save = {
            timeout_ms = 500,
            lsp_fallback = true,
        },
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "ruff_fix", "ruff_format" },
            rust = { "rustfmt" },
            markdown = { "prettier" },
            javascript = { "prettier" },
        },
    },
}
