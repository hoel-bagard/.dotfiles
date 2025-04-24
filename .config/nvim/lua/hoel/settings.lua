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

-- Set some symbols for list mode (not that I use it often).  TODO: remove this ?
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions.
vim.opt.inccommand = "split"

-- Show which line the cursor is on.  TODO: activate once a theme is installed.
-- vim.opt.cursorline = true

-- vim.opt.colorcolumn = "120"

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- I don't plan on using modelines, and it seems like having them on might cause issues, so turning them off just in case.
vim.opt.modeline = false

-- Spelling
vim.opt.spelllang = "en"
vim.opt.spell = true

-- Diagnostics
-- Define icons for diagnostic errors.
-- https://neovim.io/doc/user/diagnostic.html#diagnostic-signs
vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

vim.diagnostic.config({
    virtual_text = {
        source = true,
        format = function(diagnostic)
            if diagnostic.user_data and diagnostic.user_data.code then
                return string.format("%s %s", diagnostic.user_data.code, diagnostic.message)
            else
                return diagnostic.message
            end
        end,
    },
    -- Make the diagnostics window a bit nicer.
    float = {
        header = "Diagnostics",
        source = true,
        border = "rounded",
    },
})
