return {
  "yetone/avante.nvim",
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  -- ⚠️ must add this setting! ! !
  build = "make",
  event = "VeryLazy",
  lazy = false,
  version = false, -- Never set this value to "*"! Never!
  ---@module 'avante'
  ---@type avante.Config
  opts = {
    provider = "ollama",
    providers = {
      ollama = {
        endpoint = "http://localhost:11434",
        model = "qwen2.5-coder:7b",
      },
    },
    hints = { enabled = false },
  },
  behaviour = {
    auto_suggestions = false,   -- Set to true if you want auto suggestions
    auto_set_highlight_group = false,
    auto_set_keymaps = true,
    auto_apply_diff_after_generation = false,
    support_paste_from_clipboard = false,
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
--    "echasnovski/mini.pick",         -- for file_selector provider mini.pick
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp",              -- autocompletion for avante commands and mentions
    "ibhagwan/fzf-lua",              -- for file_selector provider fzf
    "stevearc/dressing.nvim",        -- for input provider dressing
    "folke/snacks.nvim",             -- for input provider snacks
    "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua",        -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
  -- Avante keymaps
  vim.keymap.set("n", "<leader>aa", function() require("avante.api").ask() end,
    { desc = "avante: ask" }),
  vim.keymap.set("v", "<leader>aa", function() require("avante.api").ask() end,
    { desc = "avante: ask" }),
  vim.keymap.set("n", "<leader>ar", function() require("avante.api").refresh() end,
    { desc = "avante: refresh" }),
  vim.keymap.set("n", "<leader>ae", function() require("avante.api").edit() end,
    { desc = "avante: edit" }),
  vim.keymap.set("n", "<leader>at", function() require("avante").toggle() end,
    { desc = "avante: toggle" }),
  vim.keymap.set("n", "<leader>ac", function() require("avante").clear() end,
    { desc = "avante: clear" }),
}
