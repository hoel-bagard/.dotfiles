local wk = require("which-key")
local icons = require("icons")

wk.add({
    { "<leader>c", group = "[C]ode" },
    { "<leader>d", group = "[D]ebug" },
    { "<leader>f", group = "[F]ind" },
    { "<leader>m", group = "[M]isc" },
    { "<leader>m", group = "[N]otes" },
    { "<leader>q", group = "[Q]uickfix/Diagnostics" },
    { "<leader>r", group = "[R]ename" },
    { "<leader>s", group = "[S]earch" },
    { "<leader>t", group = "[T]oggle" },
    { "<leader>w", group = "[W]orkspace" }, -- TODO: change to windows

    {
        "<leader>?",
        function()
            require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
    },
})

-- Clear highlight on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Save all unsaved buffers and then quits them all. Also mapped to ZZ by default.
vim.keymap.set("n", "<C-q>", ":xa<CR>", { desc = "[Q]uit all", noremap = true, silent = true })

-- Diagnostic keymaps
-- stylua: ignore start
vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "Go to next [D]iagnostic message" })
-- stylua: ignore end
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
-- Note: A location list is a window-local quickfix list.(c.f. https://neovim.io/doc/user/quickfix.html)
vim.keymap.set("n", "<leader>qb", vim.diagnostic.setloclist, { desc = "Add buffer diagnostics to the location list." })
local function toggle_loclist()
    for _, win in pairs(vim.fn.getwininfo()) do
        if win.loclist == 1 then
            vim.cmd("lclose")
            return
        end
    end
    vim.cmd("lopen")
end
vim.keymap.set("n", "<leader>qq", toggle_loclist, { noremap = true, silent = true })
local function toggle_quickfix()
    for _, win in pairs(vim.fn.getwininfo()) do
        if win.quickfix == 1 then
            vim.cmd("cclose")
            return
        end
    end
    vim.cmd("copen")
end
vim.keymap.set("n", "<leader>qf", toggle_quickfix, { noremap = true, silent = true })

-- Move window focus.
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Change file / buffer
-- stylua: ignore start
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
vim.keymap.set("n", "<leader>fa", function() builtin.find_files({ hidden = true, no_ignore = true }) end, { desc = "[F]ind [A]ll" })
vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "[F]ind [R]ecent" })
vim.keymap.set("n", "<leader>fp", builtin.git_files, { desc = "[F]ind [P]roject (git) files" })
vim.keymap.set("n", "<leader>fg", require("multigrep").live_multigrep, { desc = "[F]ind [G]rep" })
vim.keymap.set("n", "<leader>fb", function() builtin.buffers({ sort_mru = true, ignore_current_buffer = true }) end, { desc = "[F]ind [Buffers]" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
vim.keymap.set("n", "<leader>bb", "<C-6>", { desc = "Previous [B]uffer" })
vim.keymap.set("n", "<leader>pt", ":Neotree<CR>", { desc = "[P]project [T]ree" })
vim.keymap.set("n", "<leader>bd", vim.cmd.bdelete, { desc = "[B]uffer [D]elete" })
vim.keymap.set("n", "<leader>fs", vim.cmd.update, { desc = "[F]ile [S]ave" })
-- stylua: ignore end

-- Oil
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<space>o", require("oil").toggle_float, { desc = "Open/close parent directory in floating mode" })

-- Move things while in highlight mode.
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor in place when using J.
vim.keymap.set("n", "J", "mzJ`z")

-- Center screen when using moving
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Paste over selection without losing buffer/register content.
vim.keymap.set("x", "<leader>p", '"_dP')
-- Delete without replacing clipboard.
vim.keymap.set("v", "<leader>d", '"_d')

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
    { "<leader>a", group = "[A]I", mode = { "n", "v" } },
    { "<leader>at", chat.toggle, desc = "AI Toggle", mode = "n" },
    { "<leader>ax", chat.reset, desc = "AI Reset", mode = "n" },
    { "<leader>as", chat.stop, desc = "AI Stop", mode = "n" },
    -- OpenCode
    { "<leader>aa", function() require("opencode").ask("@this: ", { submit = true }) end, desc = "AI Ask", mode = "v"},
})

-- Git
local snacks = require("snacks")
local gitsigns = require("gitsigns")
-- stylua: ignore
wk.add({
    { "<leader>g", group = "[G]it", icon = {icon = icons.git, color="orange" } },
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
    { "<leader>h", group = "Git [H]unks", icon = {icon = icons.git, color="orange" } },
    -- Navigation
    { "<leader>]c", function() if vim.wo.diff then vim.cmd.normal({ "]c", bang = true }) else gitsigns.nav_hunk("next") end end, desc = "Jump to next git [c]hange", mode = "n" },
    { "<leader>[c", function() if vim.wo.diff then vim.cmd.normal({ "[c", bang = true }) else gitsigns.nav_hunk("prev") end end, desc = "Jump to previous git [c]hange", mode = "n" },
    -- Actions
    { "<leader>hs", function() gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, desc = "[S]tage git hunk", mode = "v" },
    { "<leader>hr", function() gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, desc = "[R]eset git hunk", mode = "v" },
    { "<leader>hs", gitsigns.stage_hunk, desc = "Git [S]tage hunk" },
    { "<leader>hr", gitsigns.reset_hunk, desc = "Git [R]eset hunk" },
    { "<leader>hS", gitsigns.stage_buffer, desc = "Git [S]tage buffer" },
    { "<leader>hu", gitsigns.undo_stage_hunk, desc = "Git [U]ndo stage hunk" },
    { "<leader>hR", gitsigns.reset_buffer, desc = "Git [R]eset buffer" },
    { "<leader>hp", gitsigns.preview_hunk, desc = "Git [P]review hunk" },
    { "<leader>hb", gitsigns.blame_line, desc = "Git [B]lame line" },
    { "<leader>hd", gitsigns.diffthis, desc = "Git [D]iff against index" },
    { "<leader>hD", function() gitsigns.diffthis("@") end, desc = "Git [D]iff against last commit" },
    -- Toggles
    { "<leader>tb", gitsigns.toggle_current_line_blame, desc = "[T]oggle git show [B]lame line" },
    { "<leader>tD", gitsigns.toggle_deleted, desc = "[T]oggle git show [D]eleted" },
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
    { "<leader>tu", function() vim.cmd.UndotreeToggle() vim.cmd.UndotreeFocus() end, desc = "Open/close undotree." },
})
