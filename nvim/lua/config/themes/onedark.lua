return {
  "navarasu/onedark.nvim",
  name = "onedark",
  priority = 1000,
  config = function()
    require('onedark').setup {
      style = 'darker',
      transparent = false,
      highlights = {
        Visual = { bg = "#264f78" },
        EndOfBuffer = { fg = "#535965" },
        CursorLineNr = { fg = "#A0A8B7", bold = true },
      }
    }
    vim.cmd("colorscheme onedark")
  end,
}
