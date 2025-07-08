return {
  -- Auto pairs
  { "windwp/nvim-autopairs", config = true },

  -- Comment toggler
  { "numToStr/Comment.nvim", config = true },

  -- File tree (optional)
  
--  { "nvim-tree/nvim-tree.lua", config = true },
  { "nvim-tree/nvim-web-devicons" },
  {
  "dstein64/vim-startuptime",
  cmd = "StartupTime",
  init = function()
    vim.g.startuptime_tries = 10
  end,
},
}

