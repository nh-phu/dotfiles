return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                panel = {
                    enabled = true,
                    auto_refresh = true,
                    keymap = {
                        accept = "<C-f>",
                        next = "<C-]>",
                        prev = "<C-[>",
                        dismiss = "<C-\\>",
                    },
                },
                suggestion = {
                    enabled = false, -- Disable inline suggestions to avoid conflicts with nvim-cmp
                    auto_trigger = false,
                },
                filetypes = {
                    ["*"] = true,
                    c = true,
                    cpp = true,
                    python = true,
                    lua = true,
                    javascript = true,
                    typescript = true,
                    rust = true,
                    go = true,
                },
            })
        end,
    },
    {
        "zbirenbaum/copilot-cmp",
        event = "InsertEnter",
        dependencies = { "zbirenbaum/copilot.lua" },
        config = function()
            require("copilot_cmp").setup()
        end,
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "main",
        dependencies = {
            { "zbirenbaum/copilot.lua" },
            { "nvim-lua/plenary.nvim" },
        },
        config = function()
            require("CopilotChat").setup({
                debug = false,
                model = 'gpt-4',
                temperature = 0.1,
                question_header = '## User ',
                answer_header = '## Copilot ',
                error_header = '## Error ',
                separator = ' ',
                show_folds = true,
                show_help = true,
                auto_follow_cursor = true,
                auto_insert_mode = false,
                clear_chat_on_new_prompt = false,
                context = 'buffers', -- Use 'buffers' for current files context

                -- Custom prompts
                prompts = {
                    Explain = {
                        prompt = "/COPILOT_EXPLAIN Write an explanation for the active selection as paragraphs of text.",
                    },
                    Review = {
                        prompt = "/COPILOT_REVIEW Review the selected code and provide constructive feedback.",
                    },
                    Fix = {
                        prompt =
                        "/COPILOT_GENERATE There is a problem in this code. Rewrite the code to fix the problem.",
                    },
                    Optimize = {
                        prompt = "/COPILOT_GENERATE Optimize the selected code to improve performance and readability.",
                    },
                    Docs = {
                        prompt = "/COPILOT_GENERATE Please add documentation comments for the selection.",
                    },
                    Tests = {
                        prompt = "/COPILOT_GENERATE Please generate comprehensive tests for my code.",
                    },
                    -- New useful prompts
                    BetterNamings = {
                        prompt = "/COPILOT_GENERATE Suggest better variable and function names for the selected code.",
                    },
                    Refactor = {
                        prompt =
                        "/COPILOT_GENERATE Refactor this code to make it more maintainable and follow best practices.",
                    },
                    Security = {
                        prompt = "/COPILOT_REVIEW Review this code for potential security vulnerabilities.",
                    },
                },
                -- Key mappings
                mappings = {
                    complete = {
                        detail = "Use @<Tab> or /<Tab> for options.",
                        insert = "<Tab>",
                    },
                    close = {
                        normal = "q",
                        insert = "<C-c>"
                    },
                    reset = {
                        normal = "<C-r>",
                        insert = "<C-r>"
                    },
                    submit_prompt = {
                        normal = "<CR>",
                        insert = "<C-s>"
                    },
                    accept_diff = {
                        normal = "<C-y>",
                        insert = "<C-y>"
                    },
                    yank_diff = {
                        normal = "gy",
                        register = '"',
                    },
                    show_diff = {
                        normal = "gd"
                    },
                    show_info = {
                        normal = "gi",
                    },
                    show_context = {
                        normal = "gc",
                    },
                },
            })

            -- Key mappings for CopilotChat
            vim.keymap.set("n", "<leader>cc", ":CopilotChat ", { desc = "CopilotChat - Quick chat" })
            vim.keymap.set("n", "<leader>ccq", function()
                local input = vim.fn.input("Quick Chat: ")
                if input ~= "" then
                    require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
                end
            end, { desc = "CopilotChat - Quick question" })
            vim.keymap.set("v", "<leader>cc", ":CopilotChatVisual ", { desc = "CopilotChat - Visual selection" })

            -- Existing commands
            vim.keymap.set("n", "<leader>cce", "<cmd>CopilotChatExplain<cr>", { desc = "CopilotChat - Explain code" })
            vim.keymap.set("n", "<leader>ccr", "<cmd>CopilotChatReview<cr>", { desc = "CopilotChat - Review code" })
            vim.keymap.set("n", "<leader>ccf", "<cmd>CopilotChatFix<cr>", { desc = "CopilotChat - Fix code" })
            vim.keymap.set("n", "<leader>cco", "<cmd>CopilotChatOptimize<cr>", { desc = "CopilotChat - Optimize code" })
            vim.keymap.set("n", "<leader>ccd", "<cmd>CopilotChatDocs<cr>", { desc = "CopilotChat - Add documentation" })
            vim.keymap.set("n", "<leader>cct", "<cmd>CopilotChatTests<cr>", { desc = "CopilotChat - Generate tests" })

            -- New commands
            vim.keymap.set("n", "<leader>ccn", "<cmd>CopilotChatBetterNamings<cr>",
                { desc = "CopilotChat - Better naming" })
            vim.keymap.set("n", "<leader>ccR", "<cmd>CopilotChatRefactor<cr>", { desc = "CopilotChat - Refactor code" })
            vim.keymap.set("n", "<leader>ccs", "<cmd>CopilotChatSecurity<cr>", { desc = "CopilotChat - Security review" })

            -- Toggle and utility
            vim.keymap.set("n", "<leader>cct", ":CopilotChatToggle<cr>", { desc = "CopilotChat - Toggle window" })
            vim.keymap.set("n", "<leader>ccx", ":CopilotChatReset<cr>", { desc = "CopilotChat - Reset conversation" })
        end,
    }
}
