return {
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- dependencies = { { "echasnovski/mini.icons", opts = {} } },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup {
        delete_to_trash = true,
        columns = {
          "icon",
          --        "permissions",
          --        "size",
          --        "mtime",
        },
        win_options = {
          signcolumn = "yes:2",
        },
        view_options = {
          show_hidden = true,
        },
      }
    end,
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" }),
    lazy = false,
  },
  {
    "refractalize/oil-git-status.nvim",

    dependencies = {
      "stevearc/oil.nvim",
    },

    config = function()
      require('oil-git-status').setup({
        show_ignored = true, -- show files that match gitignore with !!
        symbols = {          -- customize the symbols that appear in the git status columns
          index = {
            ["!"] = "!",
            ["?"] = "?",
            ["A"] = "A",
            ["C"] = "C",
            ["D"] = "D",
            ["M"] = "M",
            ["R"] = "R",
            ["T"] = "T",
            ["U"] = "U",
            [" "] = " ",
          },
          working_tree = {
            ["!"] = "!",
            ["?"] = "?",
            ["A"] = "A",
            ["C"] = "C",
            ["D"] = "D",
            ["M"] = "M",
            ["R"] = "R",
            ["T"] = "T",
            ["U"] = "U",
            [" "] = " ",
          },
        },
      })
    end,
  },
}
