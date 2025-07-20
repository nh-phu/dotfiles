return {
      "rose-pine/neovim",
      name = "rose-pine",
      config = function()
        require("rose-pine").setup({
          variant = "moon",
          dark_variant = "main",
          styles = {
            transparency = false,
          },
        })
        vim.cmd("colorscheme rose-pine")
      end,
 }
