return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    priority = 800,
    lazy = false,
    config = function()
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        highlight = { enable = true },
        incremental_selection = { enable = true },
        indent = { enable = true },
        ensure_installed = {
          "asm",
          "bash",
          "c",
          "cpp",
          "editorconfig",
          "diff",
          "jsdoc",
          "json",
          "jsonc",
          "lua",
          "luadoc",
          "luap",
          "markdown",
          "markdown_inline",
          "printf",
          "python",
          "regex",
          "rust",
          "vim",
          "vimdoc",
        },
      })
    end,
  },

  {
    "RRethy/vim-illuminate",
    config = function()
      -- Configure vim-illuminate
      require('illuminate').configure({
        providers = {
          'lsp',
          'treesitter',
          'regex',
        },
        delay = 100, -- delay in milliseconds
        filetypes_denylist = {
          'dirvish',
          'fugitive',
        },
      })
    end,
  },
}
