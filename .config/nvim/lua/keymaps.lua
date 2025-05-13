require("which-key").add({
    { "<leader>c", group = "[C]ode" },
    { "<leader>d", group = "[D]ocument" },
    { "<leader>r", group = "[R]ename" },
    { "<leader>s", group = "[S]earch" },
    { "<leader>w", group = "[W]orkspace" },

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
vim.keymap.set("n", "[d", function()
    vim.diagnostic.jump({ count = -1 })
end, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", function()
    vim.diagnostic.jump({ count = 1 })
end, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a more intuitive shortcut. This does not work, most likely because of the zsh vi-mode plugin.
-- Otherwise, the default shortcut is <C-\><C-n>.
-- vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode", silent = true })

-- Move window focus.
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Change file / buffer
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
vim.keymap.set("n", "<leader>fa", function()
    builtin.find_files({ hidden = true, no_ignore = true })
end, { desc = "[F]ind [A]ll" })
vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "[F]ind [R]ecent" })
vim.keymap.set("n", "<leader>fp", builtin.git_files, { desc = "[F]ind [P]roject (git) files" })
-- vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind [G]rep" })
vim.keymap.set("n", "<leader>fg", require("multigrep").live_multigrep, { desc = "[F]ind [G]rep" })
vim.keymap.set("n", "<leader>fb", function()
    builtin.buffers({ sort_mru = true, ignore_current_buffer = true })
end, { desc = "[F]ind [Buffers]" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
vim.keymap.set("n", "<leader>bb", "<C-6>", { desc = "Previous [B]uffer" })
vim.keymap.set("n", "<leader>pt", ":Neotree<CR>", { desc = "[P]project [T]ree" })

vim.keymap.set("n", "<leader>bd", vim.cmd.bdelete, { desc = "[B]uffer [D]elete" })
vim.keymap.set("n", "<leader>fs", vim.cmd.update, { desc = "[F]ile [S]ave" })

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
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')

-- TODO: useful ?
-- To switch between projects
-- https://youtu.be/w7i4amO_zaE?si=EnRh9FKDKu5SE1Z5&t=1696
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
-- vim.keymap.set("n", "<leader>f", function()
--     vim.lsp.buf.format()
-- end)

-- TODO: Quickfix list
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")

-- [[ Unused (for now) Keymaps ]]
-- vim.keymap.set("n", "<leader>f", function()
--     require("conform").format({ async = true, lsp_fallback = true })
-- end, { desc = "[F]ormat buffer" })
