-- Autoformat
-- Core conform.nvim setup.
-- Language-specific formatters are configured in lua/plugins/languages/*.lua

---@module "conform"

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
    },
}
