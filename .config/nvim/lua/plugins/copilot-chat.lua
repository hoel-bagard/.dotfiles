local icons = require("icons")

---@type LazyPluginSpec
return {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
        { "zbirenbaum/copilot.lua" },
        { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    event = "VeryLazy",
    build = "make tiktoken",
    ---@type CopilotChat.config
    opts = {
        system_prompt = "COPILOT_INSTRUCTIONS", -- System prompt to use (can be specified manually in prompt via /).
        model = "claude-sonnet-4.5", -- See ':CopilotChatModels' for available models
        agent = "copilot", -- Default agent to use, see ':CopilotChatAgents' for available agents (can be specified manually in prompt via @).
        temperature = 0, -- GPT result temperature

        question_header = " " .. icons.user .. " ",
        answer_header = " " .. icons.bot .. " ",
        error_header = "> " .. icons.warn .. " ",

        window = {
            layout = "vertical", -- 'vertical', 'horizontal', 'float', 'replace', or a function that returns the layout
            width = 0.5, -- fractional width of parent, or absolute width in columns when > 1
            height = 0.5, -- fractional height of parent, or absolute height in rows when > 1
            -- Options below only apply to floating windows
            relative = "editor", -- 'editor', 'win', 'cursor', 'mouse'
            border = "single", -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
            row = nil, -- row position of the window, default is centered
            col = nil, -- column position of the window, default is centered
            title = "Copilot Chat", -- title of chat window
            footer = nil, -- footer of chat window
            zindex = 1, -- determines if window is on top or below other floating windows
        },

        chat_autocomplete = true, -- Enable chat autocompletion (when disabled, requires manual `mappings.complete` trigger)

        -- default prompts
        -- see https://github.com/CopilotC-Nvim/CopilotChat.nvim/blob/main/lua/CopilotChat/config/prompts.lua for implementation
        prompts = {},
    },

    ---@param opts CopilotChat.config
    config = function(_, opts)
        require("copilot").setup() -- This line is required to be able to call the auth during the first setup
        local chat = require("CopilotChat")
        chat.setup(opts)

        vim.api.nvim_create_autocmd("BufEnter", {
            desc = "Disable line numbers in chat window",
            group = vim.api.nvim_create_augroup("chat-window", { clear = true }),
            pattern = "copilot-*",
            callback = function()
                vim.opt_local.relativenumber = false
                vim.opt_local.number = false
            end,
        })
    end,
}
