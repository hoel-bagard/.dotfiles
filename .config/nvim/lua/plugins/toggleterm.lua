---@type LazyPluginSpec
return {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
        size = 120,
        open_mapping = [[<c-\>]],
        hide_numbers = true,

        -- The shading does not seem to work =(
        shade_terminals = true,
        shading_factor = -30,
        shading_ratio = -3,

        start_in_insert = true,
        -- Whether or not the open mapping applies in insert mode.
        insert_mappings = true,
        persist_size = true,
        direction = "float",
        -- Close the terminal window when the process exits.
        close_on_exit = true,
        -- Change the default shell. Can be a string or a function returning a string.
        shell = vim.o.shell,
        float_opts = {
            border = "curved",
        },
    },
}
