return {
    "ggandor/flit.nvim",
    dependencies = {
        "ggandor/leap.nvim",
        "tpope/vim-repeat",
    },
    opts = {
        keys = { f = "f", F = "F", t = "t", T = "T" },
        -- Since the labeled mode is somewhat of a duplicate of leap, deactivate it.
        -- Use "nv" to activate it in both normal and visual modes.
        labeled_modes = "",
        -- Repeat with the trigger key itself.
        clever_repeat = true,
        multiline = true,
    },
}
