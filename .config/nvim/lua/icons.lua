-- Finding icons is hard, so they are centralized here.
-- Use the Nerd Fonts cheatsheet to find more: https://www.nerdfonts.com/cheat-sheet
--
---@class icons
return {
    -- TODO: reverse flat hierarchy, use sub-tables.
    -- Folds
    fold_closed = "",
    fold_open = "",
    -- UI
    user = " ",
    bot = " ",
    git = "",
    -- Diagnostics
    error = " ",
    warn = " ",
    hint = " ",
    info = " ",
    gitsigns = {
        add = "~",
        change = "~",
        delete = "_",
        top_delete = "‾",
        change_delete = "~",
        untracked = "┆",
    },
}
