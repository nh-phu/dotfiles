return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- optional icons
  },
  config = function()
    require("nvim-tree").setup({
      sync_root_with_cwd = true,
      actions = {
      open_file = {
        quit_on_open = true,
      },
      },
      update_focused_file = {
        enable = true,
        update_root = true,
      },
      view = {
        width = 30,
      },

      renderer = {
        add_trailing = false,
        group_empty = false,
        full_name = false,
        root_folder_label = ":~:s?$?/..?",
        indent_width = 2,
        special_files = { "cargo.toml", "makefile", "readme.md", "readme.md" },
        hidden_display = "none",
        symlink_destination = true,
        decorators = { "git", "open", "hidden", "modified", "bookmark", "diagnostics", "copied", "cut", },
        highlight_git = "none",
        highlight_diagnostics = "none",
        highlight_opened_files = "none",
        highlight_modified = "none",
        highlight_hidden = "none",
        highlight_bookmarks = "none",
        highlight_clipboard = "name",
        indent_markers = {
          enable = false,
          inline_arrows = true,
          icons = {
            corner = "└",
            edge = "│",
            item = "│",
            bottom = "─",
            none = " ",
          },
        },

        icons = {
          web_devicons = {
            file = {
              enable = true,
              color = true,
            },
            folder = {
              enable = false,
              color = true,
            },
          },
          git_placement = "before",
          modified_placement = "after",
          hidden_placement = "after",
          diagnostics_placement = "signcolumn",
          bookmarks_placement = "signcolumn",
          padding = " ",
          symlink_arrow = " ➛ ",
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
            modified = true,
            hidden = false,
            diagnostics = true,
            bookmarks = true,

          },
          glyphs = {
            default = "",
            symlink = "",
            bookmark = "󰆤",
            modified = "●",
            hidden = "󰜌",
            folder = {
              arrow_closed = "",
              arrow_open = "",
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
              symlink_open = "",
            },

            git = {
              unstaged = "✗",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "★",
              deleted = "",
              ignored = "◌",
            },
          },
        },
      },
      filters = {
        dotfiles = false,
      },
    })

    -- Optional keymap
    -- lua/config/nvimtree-toggle-path.lua
    vim.keymap.set("n", "<leader>o", function()
      vim.ui.input({
        prompt = "Enter directory path (leave blank for project root): ",
        completion = "dir"
        }, function(input)
          if input == nil then return end
        local path = input
        if not input or input == "" then
          path = vim.fn.getcwd()
        else
          path = vim.fs.normalize(vim.fn.expand(input))
          path = vim.fn.fnamemodify(path, ":p")
        end

        if vim.fn.isdirectory(path) == 1 then
          -- Change working directory
          vim.cmd("cd " .. vim.fn.fnameescape(path))

          -- Use nvim-tree API to reopen tree at the new root
          local api = require("nvim-tree.api")
          api.tree.close()
          api.tree.open()
        else
          vim.notify("Invalid directory: " .. path, vim.log.levels.ERROR)
        end
      end)
    end, { desc = "Prompt for path and open NvimTree" })
    vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "NvimTree Toggle" })
  end,
}
