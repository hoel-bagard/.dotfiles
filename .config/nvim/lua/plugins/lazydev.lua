-- The @module part is mainly to make the lazydev types be available in the workspace, c.f. link below.
-- https://github.com/folke/lazydev.nvim/issues/25#issuecomment-2153142682
---@module "lazydev"

---@brief
---
--- https://github.com/folke/lazydev.nvim
---
--- Faster LuaLS setup for Neovim. Made by folke, hence trusted.

---@type LazyPluginSpec
return {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files

    ---@type lazydev.Config
    opts = {
        ---@type lazydev.Library.spec[]
        library = {
            -- Always load lazy to be able to use LazyPluginSpec. C.f. the link below.
            -- https://github.com/folke/lazydev.nvim?tab=readme-ov-file#%EF%B8%8F-limitations
            "lazy.nvim",
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
    },
}
