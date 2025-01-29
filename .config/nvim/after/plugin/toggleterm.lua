local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
    return
end

toggleterm.setup({
    size = 120,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_terminals = true,
    start_in_insert = true,
    -- Whether or not the open mapping applies in insert mode.
    insert_mappings = true,
    persist_size = true,
    direction = "float",
    -- Close the terminal window when the process exits.
    close_on_exit = true,
    -- Change the default shell. Can be a string or a function returning a string.
    shell = vim.o.shell,
})

local keymap = vim.keymap.set
local s_opts = { silent = true }
keymap("t", "<esc>", [[<C-\><C-n>]], s_opts)
