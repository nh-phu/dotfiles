return {
  -- other plugins ...

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",  -- load on command
    event = "InsertEnter", -- or on InsertEnter to start automatically
    config = function()
      require("copilot").setup({
        panel = {
          enabled = true,
          auto_refresh = true,
          keymap = {
            accept = "<CR>",
            next = "<C-]>",
            prev = "<C-[>",
            dismiss = "<C-\\>",
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<C-f>",
            accept_word = false,
            accept_line = false,
            next = "<C-]>",
            prev = "<C-[>",
            dismiss = "<C-\\>",
          },
        },
        filetypes = {
          -- disable for some filetypes if you want
          ["*"] = true,
          -- ["markdown"] = false,
        },
        -- optionally, you can add copilot_token here or use environment variables
      })
    end,
  },

  -- other plugins ...
}

