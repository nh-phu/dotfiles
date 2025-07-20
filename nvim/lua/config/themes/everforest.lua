return{
  "sainnhe/everforest",
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.everforest_background = "medium" -- best for contrast
    vim.g.everforest_enable_italic = 1
    vim.g.everforest_transparent_background = 1 -- optional
    vim.cmd("colorscheme everforest")
  end,
}
