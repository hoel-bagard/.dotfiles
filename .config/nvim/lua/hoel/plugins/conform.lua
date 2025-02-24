-- Autoformat
return {
    "stevearc/conform.nvim",
    lazy = false,
    opts = {
        -- log_level = vim.log.levels.DEBUG,
        notify_on_error = true,
        format_on_save = {
            timeout_ms = 500,
            lsp_fallback = true,
        },
        formatters = {
            dioxus_fmt = {
                command = "dx",
                args = { "fmt", "--file", "$FILENAME" },
                stdin = false,
            },
        },
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
            rust = { "rustfmt", "dioxus_fmt" },
            markdown = { "prettier" },
            json = { "prettier" },
            javascript = { "prettier" },
            bash = { "shfmt" },
            sh = { "shfmt" },
            toml = { "taplo" },
            yaml = { "yamlfmt" },
            just = { "just" },
            css = { "rustywind", "prettier" },
            -- ["*"] = { "typos" },
        },
    },
}
