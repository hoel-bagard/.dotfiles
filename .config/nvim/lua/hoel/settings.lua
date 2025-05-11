-- [[ Various settings ]]
-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode.
vim.opt.mouse = "a"

-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = "unnamedplus"

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true
vim.opt.undodir = os.getenv("XDG_STATE_HOME") .. "/nvim/undo"

-- Tabs / indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Search
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor when in list mode (and enable list mode).
-- See `:help 'list'` and `:help 'listchars'`
vim.opt.list = true
---@diagnostic disable-next-line: missing-fields
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions.
vim.opt.inccommand = "split"

-- Make the line number of the line the cursor is on stand out.
vim.opt.cursorline = true

-- vim.opt.colorcolumn = "120"

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- I don't plan on using modelines, and it seems like having them on might cause issues, so turning them off just in case.
vim.opt.modeline = false

-- Spelling
vim.opt.spelllang = "en"
vim.opt.spell = true

-- Diagnostic Config
-- See :help vim.diagnostic.Opts
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.INFO] = " ",
            [vim.diagnostic.severity.HINT] = "󰌵",
        },
        -- The numhl makes the line number (be it absolute or relative) be highlighted/colored as an error or warning.
        -- numhl = {
        --     [vim.diagnostic.severity.ERROR] = "ErrorMsg",
        --     [vim.diagnostic.severity.WARN] = "WarningMsg",
        -- },
    },

    severity_sort = true,

    virtual_text = {
        source = true,
        spacing = 2,
    },

    -- Make the diagnostics window a bit nicer.
    float = {
        header = "Diagnostics",
        source = true,
        border = "rounded",
    },
})

-- Highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})
