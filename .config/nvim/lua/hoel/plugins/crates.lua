return {
    "saecki/crates.nvim",
    tag = "stable",
    event = { "BufRead Cargo.toml" },
    config = function()
        require("crates").setup({
            lsp = {
                enabled = true,
                on_attach = function()
                    vim.lsp.enable("crates")
                end,
                actions = true,
                completion = true,
                hover = true,
            },
        })
    end,
}
