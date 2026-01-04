local wk = require("which-key")
local icons = require("icons")
local builtin = require("telescope.builtin")

wk.add({
    { "<leader>c", group = "Code" },
    { "<leader>d", group = "Debug" },
    { "<leader>f", group = "Find" },
    { "<leader>m", group = "Misc" },
    { "<leader>m", group = "Notes" },
    { "<leader>q", group = "Quickfix/Diagnostics" },
    { "<leader>r", group = "Rename" },
    { "<leader>s", group = "Search" },
    { "<leader>t", group = "Toggle" },
    {
        "<leader>?",
        function()
            require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
    },
    { "<leader>w", proxy = "<c-w>", group = "windows" }, -- proxy to window mappings
})

wk.add({
    -- Clear highlight on search when pressing <Esc> in normal mode
    { "<Esc>", "<cmd>nohlsearch<CR>", desc = "Clear search highlight" },
    -- Save all unsaved buffers and then quits them all. Also mapped to ZZ by default.
    { "<C-q>", ":xa<CR>", desc = "Quit all" },
})

-- Diagnostic keymaps
wk.add({
    -- stylua: ignore start
    { "[d", function() vim.diagnostic.jump({ count = -1 }) end, desc = "Go to previous diagnostic message" },
    { "]d", function() vim.diagnostic.jump({ count = 1 }) end, desc = "Go to next diagnostic message" },
    { "<leader>e", vim.diagnostic.open_float, desc = "Show diagnostic error messages" },
    -- Note: A location list is a window-local quickfix list.(c.f. https://neovim.io/doc/user/quickfix.html)
    { "<leader>qb", vim.diagnostic.setloclist, desc = "Add buffer diagnostics to the location list." },
})

-- TODO: Learn how to use these.
local function toggle_loclist()
    for _, win in pairs(vim.fn.getwininfo()) do
        if win.loclist == 1 then
            vim.cmd("lclose")
            return
        end
    end
    vim.cmd("lopen")
end
local function toggle_quickfix()
    for _, win in pairs(vim.fn.getwininfo()) do
        if win.quickfix == 1 then
            vim.cmd("cclose")
            return
        end
    end
    vim.cmd("copen")
end
wk.add({
    { "<leader>qq", toggle_loclist, desc = "Toggle location list" },
    { "<leader>qf", toggle_quickfix, desc = "Toggle quickfix list" },
})

-- Move window focus.
wk.add({
    { "<C-h>", "<C-w><C-h>", desc = "Move focus to the left window" },
    { "<C-l>", "<C-w><C-l>", desc = "Move focus to the right window" },
    { "<C-j>", "<C-w><C-j>", desc = "Move focus to the lower window" },
    { "<C-k>", "<C-w><C-k>", desc = "Move focus to the upper window" },
})

-- Change file / buffer
wk.add({
    -- stylua: ignore start
    mode={ "n", "v" },
    -- Files
    { "<leader>ff", builtin.find_files, desc = "Find Files" },
    { "<leader>fa", function() builtin.find_files({ hidden = true, no_ignore = true }) end, desc = "Find All" },
    { "<leader>fr", builtin.oldfiles, desc = "Find Recent" },
    { "<leader>fp", builtin.git_files, desc = "Find Project" },
    { "<leader>fg", require("multigrep").live_multigrep, desc = "Find Grep" },
    { "<leader>fb", function() builtin.buffers({ sort_mru = true, ignore_current_buffer = true }) end, desc = "Find Buffers" },
    { "<leader>fs", vim.cmd.update, desc = "File Save" },
    -- Buffers
    { "<leader>b", group = "buffers", expand = function() return require("which-key.extras").expand.buf() end },
    { "<leader>bb", "<C-6>",  desc = "Previous Buffer" },
    { "<leader>bd", vim.cmd.bdelete,  desc = "Buffer Delete" },
})

-- Misc
wk.add({
    -- Oil
    { "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
    { "<space>o", require("oil").toggle_float, desc = "Open/close parent directory in floating mode" },

    -- Move things while in highlight mode.
    { "J", ":m '>+1<CR>gv=gv", desc = "Move selection down", mode = "v" },
    { "K", ":m '<-2<CR>gv=gv", desc = "Move selection up", mode = "v" },

    -- Keep cursor in place when using J.
    { "J", "mzJ`z", desc = "Join lines" },

    -- Center screen when using moving
    { "<C-d>", "<C-d>zz", desc = "Scroll down" },
    { "<C-u>", "<C-u>zz", desc = "Scroll up" },

    -- Paste over selection without losing buffer/register content.
    { "<leader>p", '"_dP', desc = "Paste without losing register", mode = "v" },
    -- Delete without replacing clipboard.
    { "<leader>d", '"_d', desc = "Delete without yanking", mode = { "n", "v" } },

    -- Other
    { "<leader>pt", ":Neotree<CR>", desc = "Project Tree" },
    { "<leader>fh", builtin.help_tags, desc = "Find Help" },
})

-- TODO: Quickfix list
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")

-- AI
local chat = require("CopilotChat")
-- stylua: ignore
wk.add({
    -- CopilotChat
    icon = { icon = icons.bot, color = "azure" },
    { "<leader>a", group = "AI", mode = { "n", "v" } },
    { "<leader>ac", chat.toggle, desc = "CopilotChat Toggle", mode = "n" },
    { "<leader>ar", chat.reset, desc = "CopilotChat Reset", mode = "n" },
    { "<leader>as", chat.stop, desc = "CopilotChat Stop", mode = "n" },
    -- OpenCode
    { "<leader>aa", function() require("opencode").ask("@this: ", { submit = true }) end, desc = "OpenCode Ask", mode = {"n", "v"}},
    { "<leader>ax", function() require("opencode").select() end, desc = "OpenCode Execute Action", mode = {"n", "v"}},
    { "<leader>at", function() require("opencode").toggle() end, desc = "OpenCode Toggle", mode = {"n", "t"}},
})

-- Git
local snacks = require("snacks")
local gitsigns = require("gitsigns")
-- stylua: ignore
wk.add({
    { "<leader>g", group = "Git", icon = {icon = icons.git, color="orange" } },
    { "<leader>gD", function() vim.cmd("DiffviewOpen master..HEAD") end, desc = "Git Diff master" },
    { "<leader>gb", function() snacks.picker.git_branches() end, desc = "Git Branches" },
    { "<leader>gl", function() snacks.picker.git_log() end, desc = "Git Log" },
    { "<leader>gL", function() snacks.picker.git_log_line() end, desc = "Git Log Line" },
    { "<leader>gs", function() snacks.picker.git_status() end, desc = "Git Status" },
    { "<leader>gS", function() snacks.picker.git_stash() end, desc = "Git Stash" },
    { "<leader>gd", function() snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
    { "<leader>gf", function() snacks.picker.git_log_file() end, desc = "Git Log File" },
    { "<leader>gB", function() snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
    -- Hunks
    { "<leader>h", group = "Git Hunks", icon = {icon = icons.git, color="orange" } },
    -- Navigation
    ---@diagnostic disable: param-type-mismatch
    { "<leader>]c", function() if vim.wo.diff then vim.cmd.normal({ "]c", bang = true }) else gitsigns.nav_hunk("next") end end, desc = "Jump to next git change", mode = "n" },
    { "<leader>[c", function() if vim.wo.diff then vim.cmd.normal({ "[c", bang = true }) else gitsigns.nav_hunk("prev") end end, desc = "Jump to previous git change", mode = "n" },
    -- Actions
    { "<leader>hs", function() gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, desc = "Stage git hunk", mode = "v" },
    { "<leader>hr", function() gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, desc = "Reset git hunk", mode = "v" },
    { "<leader>hs", gitsigns.stage_hunk, desc = "Git stage hunk" },
    { "<leader>hr", gitsigns.reset_hunk, desc = "Git reset hunk" },
    { "<leader>hS", gitsigns.stage_buffer, desc = "Git stage buffer" },
    { "<leader>hu", gitsigns.stage_hunk, desc = "Git undo stage hunk" },  -- Must be run with cursor on lines with staged signs
    { "<leader>hR", gitsigns.reset_buffer, desc = "Git reset buffer" },
    { "<leader>hp", gitsigns.preview_hunk, desc = "Git preview hunk" },
    { "<leader>hb", gitsigns.blame_line, desc = "Git blame line" },
    { "<leader>hd", gitsigns.diffthis, desc = "Git diff against index" },
    { "<leader>hD", function() gitsigns.diffthis("@") end, desc = "Git diff against last commit" },
    -- Toggles
    { "<leader>tb", gitsigns.toggle_current_line_blame, desc = "Toggle git show blame line" },
    { "<leader>tD", gitsigns.toggle_deleted, desc = "Toggle git show deleted" },
})

-- TODOs
-- stylua: ignore
wk.add({
    { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
    { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },

    { "<leader>qt", "<cmd>TodoQuickFix<cr>", desc = "Add TODOs to QuickFix " },
    { "<leader>qT", "<cmd>TodoQuickFix keywords=TODO,FIX,FIXME<cr>", desc = "Add TODO/FIX to QuickFix " },
    { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Search TODO" },
    { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Search TODO/FIX" },
})

-- Conform
---Toggle auto-formatting globally (it is also possible to toggle for the buffer only, but I do not need that).
local function toggle_autoformat()
    vim.b.disable_autoformat = not vim.g.disable_autoformat
    vim.g.disable_autoformat = not vim.g.disable_autoformat

    vim.g.obsidian_frontmatter_disabled = not vim.g.obsidian_frontmatter_disabled

    if vim.g.disable_autoformat then
        require("noice").notify("Disabled auto-formatting globally", "info", { title = "AutoFormatting" })
    else
        require("noice").notify("Enabled auto-formatting globally", "info", { title = "AutoFormatting" })
    end
end
wk.add({
    { "<leader>uC", "<cmd>ConformInfo<cr>", desc = "Conform information" },
    { "<leader>tf", toggle_autoformat, desc = "Toggle auto-format" },
})

-- Obsidian
-- stylua: ignore
wk.add({
    { "gf", function() return require("obsidian").util.gf_passthrough() end, desc = "Follow links" },
    { "<leader>nn", "<cmd>ObsidianNew<cr>", desc = "Create a new note" },
    { "<leader>ny", "<cmd>ObsidianYesterday <cr>", desc = "Open/create yesterday's daily note." },
    { "<leader>nt", "<cmd>ObsidianToday<cr>", desc = "Open/create today's daily note." },
    { "<leader>nm", "<cmd>ObsidianTomorrow  <cr>", desc = "Open/create tomorrow's daily note." },
})


-- Nvim DAP
-- stylua: ignore
wk.add({
    { "<F1>", function() require("dap").continue() end, desc = "Debug: Start/Continue" },
    { "<leader>dn", function() require("dap").continue() end, desc = "Debug: New/Continue" },
    { "<leader>de", function() require("dap").disconnect() end, desc = "Debug: Exit" },
    { "<leader>di", function() require("dap").step_into() end, desc = "Debug: Step Into" },
    { "<leader>do", function() require("dap").step_over() end, desc = "Debug: Step Over" },
    { "<leader>dO", function() require("dap").step_out() end, desc = "Debug: Step Out" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle Breakpoint" },
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Debug: Set Breakpoint" },
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    { "<leader>ds", function() require("dapui").toggle() end, desc = "Debug: See last session result." },
})

-- Undotree
-- stylua: ignore
wk.add({
    { "<leader>tu", function() vim.cmd.UndotreeToggle() vim.cmd.UndotreeFocus() end, desc = "Toggle undotree." },
})
