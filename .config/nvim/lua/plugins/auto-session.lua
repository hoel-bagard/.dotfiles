-- Note:
-- I picked auto-session over resession.nvim since in the end I would just configure "resession" to get the same result as default "auto-session".

---@type LazyPluginSpec
return {
    "rmagatti/auto-session",
    lazy = false,

    keys = {
        { "<leader>sl", "<cmd>AutoSession search<CR>", desc = "Session search" },
        { "<leader>ss", "<cmd>AutoSession save<CR>", desc = "Session save" },
        { "<leader>sd", "<cmd>AutoSession delete<CR>", desc = "Session delete" },
    },

    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
        bypass_save_filetypes = { "snacks_dashboard" },
        session_lens = {
            picker = "telescope", -- Or nil to auto-detect.
            -- Default mappings, just writing them here to not forget them.
            mappings = {
                delete_session = { { "i", "n" }, "<C-d>" },
                alternate_session = { { "i", "n" }, "<C-s>" },
                copy_session = { { "i", "n" }, "<C-y>" },
            },
            -- Telescope only: If load_on_setup is false, make sure you use `:AutoSession search` to open the picker as it will initialize everything first
            load_on_setup = true,
        },
    },

    ---@param opts AutoSession.Config
    config = function(_, opts)
        require("auto-session").setup(opts)
        vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    end,
}
