---@type LazyPluginSpec
return {
    "mfussenegger/nvim-dap",
    dependencies = {
        -- Debugger UI and its dependency
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",

        -- To installs the debug adapters.
        "mason-org/mason.nvim",
        "jay-babu/mason-nvim-dap.nvim",

        -- Debug adapters
        { url = "https://codeberg.org/mfussenegger/nvim-dap-python.git" },
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        require("mason-nvim-dap").setup({
            -- Makes a best effort to setup the various debuggers with reasonable debug configurations
            automatic_installation = true,

            -- You can provide additional configuration to the handlers, see mason-nvim-dap README for more information
            handlers = {},

            ensure_installed = {
                "debugpy",
            },
        })

        -- Change breakpoint icons
        vim.api.nvim_set_hl(0, "DapBreak", { fg = "#e51400" })
        vim.api.nvim_set_hl(0, "DapStop", { fg = "#ffcc00" })
        local breakpoint_icons = {
            Breakpoint = "",
            BreakpointCondition = "⊜",
            BreakpointRejected = "⊘",
            LogPoint = "",
            Stopped = "",
        }
        for type, icon in pairs(breakpoint_icons) do
            local name = "Dap" .. type
            local highlight = (type == "Stopped") and "DapStop" or "DapBreak"
            vim.fn.sign_define(name, { text = icon, texthl = highlight, numhl = highlight })
        end

        dapui.setup()
        dap.listeners.after.event_initialized["dapui_config"] = dapui.open
        dap.listeners.before.event_terminated["dapui_config"] = dapui.close
        dap.listeners.before.event_exited["dapui_config"] = dapui.close

        require("dap-python").setup("uv")
    end,
}
