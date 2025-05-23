---@type LazyPluginSpec
return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lint = require("lint")
        lint.linters_by_ft = {
            -- Configuration wasn't intuitive, use prettier to format on save instead.
            -- markdown = { "markdownlint" },
            json = { "jsonlint" },
            dockerfile = { "hadolint" },
        }

        -- Create autocommand which carries out the actual linting on the specified events.
        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            group = lint_augroup,
            callback = function()
                require("lint").try_lint()
            end,
        })
    end,
}
