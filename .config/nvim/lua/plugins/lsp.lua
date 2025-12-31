-- LSP Configuration
-- Core LSP setup: keymaps, LspAttach autocmd, capabilities, Mason orchestration.
-- Server-specific configurations are in lua/plugins/languages/*.lua

-- Shared capabilities (includes nvim-cmp completion capabilities)
-- This is set up once and shared across all language server configurations
-- _capabilities is for memoization, should be slightly faster.
local _capabilities = nil
local function get_capabilities()
    if _capabilities then
        return _capabilities
    end
    _capabilities = vim.lsp.protocol.make_client_capabilities()
    -- Only extend with cmp capabilities if cmp_nvim_lsp is available
    local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if ok then
        _capabilities = vim.tbl_deep_extend("force", _capabilities, cmp_nvim_lsp.default_capabilities())
    end
    return _capabilities
end

-- Export for use by language files
_G.LspCapabilities = get_capabilities

---@type LazyPluginSpec
return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        -- Useful status updates for LSP.
        { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
        --  This function gets run when an LSP attaches to a particular buffer.
        --    That is to say, every time a new file is opened that is associated with
        --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
        --    function will be executed to configure the current buffer
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
            callback = function(event)
                local map = function(keys, func, desc)
                    vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                end
                --  To jump back, press <C-t>.
                map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
                map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

                -- Jump to the implementation of the word under the cursor.
                --  Useful when your language has ways of declaring types without an actual implementation.
                map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

                -- Jump to the type of the word under the cursor.
                --  Useful when you"re not sure what type a variable is and you want to see
                --  the definition of its *type*, not where it was *defined*.
                map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

                -- Fuzzy find all the symbols in the current workspace.
                --  Similar to document symbols, except searches over your entire project.
                map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

                -- Rename the variable under the cursor.
                --  Most Language Servers support renaming across files, etc.
                map("<leader>r", vim.lsp.buf.rename, "[R]ename")

                -- Execute a code action, usually the cursor needs to be on top of an error
                -- or a suggestion from your LSP for this to activate.
                -- For example to activate the "auto-complete" import on a function/class that was typed manually.
                map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

                -- Opens a popup that displays documentation about the word under the cursor
                map("K", vim.lsp.buf.hover, "Hover Documentation")

                -- This is not Goto Definition, this is Goto Declaration. For example, in C this would take you to the header.
                map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

                -- The following two autocommands are used to highlight references of the
                -- word under the cursor when the cursor rests there for a little while.
                --    See `:help CursorHold` for information about when this is executed
                --
                -- When the cursor moves, the highlights will be cleared (the second autocommand).
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client and client.server_capabilities.documentHighlightProvider then
                    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                        buffer = event.buf,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                        buffer = event.buf,
                        callback = vim.lsp.buf.clear_references,
                    })
                end
            end,
        })

        -- Ensure the servers and tools above are installed
        require("mason").setup()

        -- Tools to install (formatters, linters, LSP servers)
        -- LSP servers are configured and enabled by language files in lua/plugins/languages/
        local ensure_installed = {
            -- Formatters
            "stylua",
            "prettier",
            "shfmt",
            "taplo",
            "yamlfmt",
            "google-java-format",
            "rustywind",
            -- Linters
            "hadolint",
            "jsonlint",
            "shellcheck",
            -- LSP servers
            "bash-language-server",
            "typos-lsp",
            "graphql-language-service-cli",
            "omnisharp",
            "tailwindcss-language-server",
        }

        require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

        require("mason-lspconfig").setup({
            ensure_installed = {},
            automatic_installation = false,
        })
    end,
}
