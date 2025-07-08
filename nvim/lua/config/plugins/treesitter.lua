return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = { enable = true },
        incremental_selection = { enable = true },
        indent = { enable = true },

        ensure_installed = {
          "asm",
          "bash",
          "c",
          "cpp",
          "diff",
          "html",
          "javascript",
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
          "query",
          "regex",
          "rust",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "xml",
          "yaml",
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
