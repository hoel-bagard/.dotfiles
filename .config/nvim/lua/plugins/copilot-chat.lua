local icons = require("icons")

return {

    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "zbirenbaum/copilot.lua" },
            { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
        },
        build = "make tiktoken",
        opts = {
            system_prompt = "COPILOT_INSTRUCTIONS", -- System prompt to use (can be specified manually in prompt via /).
            model = "claude-3.7-sonnet", -- "gpt-4.1", see ':CopilotChatModels' for available models
            agent = "copilot", -- Default agent to use, see ':CopilotChatAgents' for available agents (can be specified manually in prompt via @).
            temperature = 0, -- GPT result temperature

            question_header = " " .. icons.ui.User .. " ",
            answer_header = " " .. icons.ui.Bot .. " ",
            error_header = "> " .. icons.diagnostics.Warn .. " ",

            -- selection = select.visual,

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
            prompts = {
                Explain = {
                    mapping = "<leader>ae",
                    description = "AI Explain",
                },
                Review = {
                    mapping = "<leader>ar",
                    description = "AI Review",
                    system_prompt = "COPILOT_REVIEW",
                    prompt = "Review the selected code.",
                },
                Tests = {
                    mapping = "<leader>aT",
                    description = "AI Tests",
                    prompt = "Generate tests for the selected code.",
                },
                Fix = {
                    mapping = "<leader>af",
                    description = "AI Fix",
                },
                Optimize = {
                    mapping = "<leader>ao",
                    description = "AI Optimize",
                    prompt = "Optimize the selected code to improve performance and readability. Explain your optimization strategy and the benefits of your changes.",
                },
                Docs = {
                    mapping = "<leader>ad",
                    description = "AI Documentation",
                    prompt = "Please add documentation comments to the selected code.",
                },
                Commit = {
                    mapping = "<leader>ac",
                    description = "AI Generate Commit",
                    -- selection = select.buffer,
                    context = "git:staged",
                    prompt = "Write commit message for the change with commitizen convention. Keep the title under 50 characters and wrap message at 72 characters. Format as a gitcommit code block.",
                },
                Translate = {
                    mapping = "<leader>ac",
                    description = "AI Translate",
                    prompt = "Translate the selected text to Japanese.",
                },
            },
        },

        -- config = function()
        --     local chat = require("CopilotChat")
        --
        --     vim.api.nvim_create_autocmd("BufEnter", {
        --         desc = "Disable line numbers in chat window",
        --         group = vim.api.nvim_create_augroup("chat-window", { clear = true }),
        --         pattern = "copilot-*",
        --         callback = function()
        --             vim.opt_local.relativenumber = false
        --             vim.opt_local.number = false
        --         end,
        --     })
        --
        --     vim.keymap.set({ "n" }, "<leader>aa", chat.toggle, { desc = "AI Toggle" })
        --     vim.keymap.set({ "v" }, "<leader>aa", chat.open, { desc = "AI Open" })
        --     vim.keymap.set({ "n" }, "<leader>ax", chat.reset, { desc = "AI Reset" })
        --     vim.keymap.set({ "n" }, "<leader>as", chat.stop, { desc = "AI Stop" })
        --     vim.keymap.set({ "n" }, "<leader>am", chat.select_model, { desc = "AI Models" })
        --     vim.keymap.set({ "n", "v" }, "<leader>ap", chat.select_prompt, { desc = "AI Prompts" })
        --     vim.keymap.set({ "n", "v" }, "<leader>aq", function()
        --         vim.ui.input({
        --             prompt = "AI Question> ",
        --         }, function(input)
        --             if input ~= "" then
        --                 chat.ask(input)
        --             end
        --         end)
        --     end, { desc = "AI Question" })
        -- end,
    },
}
