return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "tailwind-tools",
            "onsails/lspkind-nvim",
        },
    },
    {
        "saadparwaiz1/cmp_luasnip",
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            {
                "L3MON4D3/LuaSnip",
                build = (function()
                    -- Build Step is needed for regex support in snippets.
                    -- This step is not supported in many windows environments.
                    if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
                        return
                    end
                    return "make install_jsregexp"
                end)(),
            },
        },
    },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-nvim-lua" },
    { "tamago324/cmp-zsh" },
    -- Fancy icons.
    { "onsails/lspkind-nvim" },
}
