-- Autoformat

--- @module "conform"

---@type LazyPluginSpec
return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },

    ---@type conform.setupOpts
    opts = {
        notify_on_error = true,
        default_format_opts = {
            lsp_format = "fallback",
        },
        format_on_save = function(bufnr)
            -- Disable with a global or buffer-local variable
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
            end
            return { timeout_ms = 500, lsp_format = "fallback" }
        end,
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
            graphql = { "prettier" },
            bash = { "shfmt" },
            sh = { "shfmt" },
            toml = { "taplo" },
            yaml = { "yamlfmt" },
            just = { "just" },
            css = { "rustywind", "prettier" },
            -- nu = { "nufmt" },
            -- ["*"] = { "typos" },
        },
    },
}
