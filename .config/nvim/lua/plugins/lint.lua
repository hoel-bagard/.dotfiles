-- Linting
-- Core nvim-lint setup.
-- Language-specific linters are configured in lua/plugins/languages/*.lua

---@class plugins.lint.opts
---@field linters_by_ft? table<string, string[]>

---@type LazyPluginSpec
return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },

    ---@type plugins.lint.opts
    opts = {
        -- Language-specific linters are added via opts merging from language files
        linters_by_ft = {},
    },

    config = function(_, opts)
        local lint = require("lint")
        lint.linters_by_ft = opts.linters_by_ft

        -- Create autocommand which carries out the actual linting on the specified events.
        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            group = lint_augroup,
            callback = function()
                lint.try_lint()
            end,
        })
    end,
}
