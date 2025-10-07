return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "VimEnter",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = true,
          auto_refresh = true,
          keymap = {
            accept = "<C-f>",
            next = "<C-n>",
            prev = "<C-p>",
            dismiss = "<C-\\>",
          },
        },
        suggestion = {
          enabled = true,
          -- disable inline suggestions to avoid conflicts with nvim-cmp
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
    event = "InsertEnter",     -- Fixed capitalization
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },

  {
    "CopilotC-Nvim/CopilotChat.nvim",     -- Fixed: was "copilotc-nvim/copilotchat.nvim"
    branch = "main",                      -- Changed from "main" to "canary" for latest features
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    config = function()
      require("CopilotChat").setup({       -- Fixed: was "copilotchat"
        debug = false,
        model = 'gpt-4.1',                 -- Upgraded from gpt-4 for better performance
        agent = 'copilot',
        temperature = 0.1,
        max_tokens = 4096,               -- Increase token limit for longer responses
        window = {
          layout = 'vertical',           -- or 'horizontal', 'float'
          width = 0.4,                   -- 40% of screen width
          height = 0.6,                  -- 60% of screen height
          relative = 'editor',
          border = 'rounded',            -- Add nice borders
          row = 1,
        },
        question_header = '## User ',
        answer_header = '## Copilot ',
        error_header = '## Error ',
        separator = ' ',
        show_folds = true,
        show_help = true,
        history_path = vim.fn.stdpath("data") .. "/copilotchat_history",         -- Persist chat history
        auto_follow_cursor = true,
        auto_insert_mode = false,
        clear_chat_on_new_prompt = false,

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
          -- Additional useful prompts
          Debug = {
            prompt = "/COPILOT_GENERATE Help me debug this code. Explain what might be wrong and suggest fixes.",
          },
          Performance = {
            prompt = "/COPILOT_REVIEW Analyze this code for performance bottlenecks and suggest optimizations.",
          },
          TypeScript = {
            prompt = "/COPILOT_GENERATE Add proper TypeScript types to this code.",
          },
          UnitTest = {
            prompt = "/COPILOT_GENERATE Create unit tests for this function with edge cases and mocking.",
          },
          APIDoc = {
            prompt = "/COPILOT_GENERATE Generate API documentation for this code with examples.",
          },
          Convert = {
            prompt = "/COPILOT_GENERATE Convert this code to [specify language/framework in your message].",
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
      vim.keymap.set("n", "<leader>cc", ":CopilotChat ",
        { desc = "CopilotChat - Quick chat" })
      vim.keymap.set("n", "<leader>ccq", function()
        local input = vim.fn.input("Quick Chat: ")
        if input ~= "" then
          require("CopilotChat").ask(input,
            { selection = require("CopilotChat.select").buffer })
        end
      end, { desc = "CopilotChat - Quick question" })

      -- Visual mode mappings
      vim.keymap.set("v", "<leader>cc", ":CopilotChatVisual ",
        { desc = "CopilotChat - Visual selection" })
      vim.keymap.set("v", "<leader>cce", ":CopilotChatExplain<cr>",
        { desc = "CopilotChat - Explain selection" })
      vim.keymap.set("v", "<leader>ccr", ":CopilotChatReview<cr>",
        { desc = "CopilotChat - Review selection" })
      vim.keymap.set("v", "<leader>ccf", ":CopilotChatFix<cr>",
        { desc = "CopilotChat - Fix selection" })

      -- Normal mode - work with current buffer/selection
      vim.keymap.set("n", "<leader>cce", "<cmd>CopilotChatExplain<cr>",
        { desc = "CopilotChat - Explain code" })
      vim.keymap.set("n", "<leader>ccr", "<cmd>CopilotChatReview<cr>",
        { desc = "CopilotChat - Review code" })
      vim.keymap.set("n", "<leader>ccf", "<cmd>CopilotChatFix<cr>",
        { desc = "CopilotChat - Fix code" })
      vim.keymap.set("n", "<leader>cco", "<cmd>CopilotChatOptimize<cr>",
        { desc = "CopilotChat - Optimize code" })
      vim.keymap.set("n", "<leader>ccd", "<cmd>CopilotChatDocs<cr>",
        { desc = "CopilotChat - Add documentation" })

      -- New commands
      vim.keymap.set("n", "<leader>ccn", "<cmd>CopilotChatBetterNamings<cr>",
        { desc = "CopilotChat - Better naming" })
      vim.keymap.set("n", "<leader>ccR", "<cmd>CopilotChatRefactor<cr>",
        { desc = "CopilotChat - Refactor code" })
      vim.keymap.set("n", "<leader>ccs", "<cmd>CopilotChatSecurity<cr>",
        { desc = "CopilotChat - Security review" })

      -- New enhanced commands
      vim.keymap.set("n", "<leader>ccD", "<cmd>CopilotChatDebug<cr>",
        { desc = "CopilotChat - Debug help" })
      vim.keymap.set("n", "<leader>ccp", "<cmd>CopilotChatPerformance<cr>",
        { desc = "CopilotChat - Performance analysis" })
      vim.keymap.set("n", "<leader>ccT", "<cmd>CopilotChatTypeScript<cr>",
        { desc = "CopilotChat - Add TypeScript types" })
      vim.keymap.set("n", "<leader>ccu", "<cmd>CopilotChatUnitTest<cr>",
        { desc = "CopilotChat - Unit tests" })
      vim.keymap.set("n", "<leader>cca", "<cmd>CopilotChatAPIDoc<cr>",
        { desc = "CopilotChat - API documentation" })
      vim.keymap.set("n", "<leader>ccC", "<cmd>CopilotChatConvert<cr>",
        { desc = "CopilotChat - Convert code" })

      -- Quick actions with floating window
      vim.keymap.set("n", "<leader>ccw", function()
        require("CopilotChat").open({
          window = { layout = 'float', width = 0.8, height = 0.8 }
        })
      end, { desc = "CopilotChat - Open float window" })

      -- Context-specific shortcuts
      vim.keymap.set("n", "<leader>ccb", function()
        require("CopilotChat").ask("Explain this entire buffer", {
          selection = require("CopilotChat.select").buffer
        })
      end, { desc = "CopilotChat - Explain buffer" })

      -- Utility mappings
      vim.keymap.set("n", "<leader>ccS", ":CopilotChatSave ",
        { desc = "CopilotChat - Save chat" })
      vim.keymap.set("n", "<leader>ccL", ":CopilotChatLoad ",
        { desc = "CopilotChat - Load chat" })

      -- Toggle and utility (Fixed duplicate <leader>cct mapping)
      vim.keymap.set("n", "<leader>cct", ":CopilotChatToggle<cr>",
        { desc = "CopilotChat - Toggle window" })
      vim.keymap.set("n", "<leader>ccx", ":CopilotChatReset<cr>",
        { desc = "CopilotChat - Reset conversation" })

      -- Add autocommands for better UX
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-chat",
        callback = function()
          vim.opt_local.relativenumber = false
          vim.opt_local.number = false
        end
      })
    end,
  }
}
