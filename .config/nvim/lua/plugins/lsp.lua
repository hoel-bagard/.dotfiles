-- LSP Configuration
-- Core LSP setup: keymaps, LspAttach autocmd, capabilities, Mason orchestration.
-- Server-specific configurations are in lua/plugins/languages/*.lua

---@class plugins.lspconfig.keymap
---@field [1] string
---@field [2] string|fun()
---@field desc string
---@field mode? string|string[]

-- NOTE: Consider switching from Telescope to Snacks.picker for LSP navigation
-- Snacks provides a more unified experience and is actively maintained.
-- See: https://github.com/folke/snacks.nvim

---LSP buffer keymaps.
---These are applied when an LSP client attaches to a buffer.
---@type plugins.lspconfig.keymap[]
local lsp_keymaps = {
    -- stylua: ignore start
    { "gd", function() require("telescope.builtin").lsp_definitions() end, desc = "Goto Definition" },
    { "gr", function() require("telescope.builtin").lsp_references() end, desc = "Goto References" },
    { "gI", function() require("telescope.builtin").lsp_implementations() end, desc = "Goto Implementation" },
    { "<leader>D", function() require("telescope.builtin").lsp_type_definitions() end, desc = "Type Definition" },
    { "<leader>ws", function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end, desc = "Workspace Symbols" },
    { "<leader>r", vim.lsp.buf.rename, desc = "Rename" },
    { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action" },
    { "K", vim.lsp.buf.hover, desc = "Hover Documentation" },
    { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
    -- stylua: ignore end
}

---Apply LSP keymaps for buffer.
---@param bufnr integer
local function apply_lsp_keymaps(bufnr)
    for _, keymap in ipairs(lsp_keymaps) do
        vim.keymap.set(
            keymap.mode or "n",
            keymap[1],
            keymap[2],
            { buffer = bufnr, desc = "LSP: " .. keymap.desc }
        )
    end
end

---Setup document highlight autocmds for buffer.
---@param client vim.lsp.Client
---@param bufnr integer
local function setup_document_highlight(client, bufnr)
    if not client.server_capabilities.documentHighlightProvider then
        return
    end

    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = bufnr,
        callback = vim.lsp.buf.document_highlight,
    })

    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
    })
end

-- Shared capabilities (includes nvim-cmp completion capabilities)
-- This is set up once and shared across all language server configurations
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
        -- Useful status updates for LSP.
        { "j-hui/fidget.nvim", opts = {} },
    },

    config = function()
        -- Setup LspAttach autocmd
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
            callback = function(event)
                local bufnr = event.buf
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if not client then
                    return
                end

                apply_lsp_keymaps(bufnr)
                setup_document_highlight(client, bufnr)
            end,
        })

        -- Setup Mason for installing LSP servers and tools
        require("mason").setup()

        -- Tools to install (formatters, linters)
        -- LSP servers are configured and enabled by language files
        local tools = {
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
        }

        require("mason-tool-installer").setup({
            ensure_installed = tools,
        })

        require("mason-lspconfig").setup({
            ensure_installed = {},
            automatic_installation = false,
        })
    end,
}
