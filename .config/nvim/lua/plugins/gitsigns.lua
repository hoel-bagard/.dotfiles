-- Adds git related signs to the gutter, as well as utilities for managing changes
---@module "gitsigns"

local icons = require("icons")

---@type LazyPluginSpec
return {
    "lewis6991/gitsigns.nvim",

    ---@type Gitsigns.Config
    ---@diagnostic disable: missing-fields
    opts = {
        signs = {
            add = { text = icons.gitsigns.add },
            change = { text = icons.gitsigns.change },
            delete = { text = icons.gitsigns.delete },
            topdelete = { text = icons.gitsigns.top_delete },
            changedelete = { text = icons.gitsigns.change_delete },
            untracked = { text = icons.gitsigns.untracked },
        },
    },
}
