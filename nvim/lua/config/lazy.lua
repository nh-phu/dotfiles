-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
--	{ "folke/tokyonight.nvim", config = function() vim.cmd.colorscheme "tokyonight" end},
{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    -- import your plugins
    { import = "config.plugins" },
  },
ui = {
  size = { width = 0.8, height = 0.8 },
  wrap = true,
  border = "rounded", -- you can change this to "rounded" or "single" for a bordered window
  backdrop = 60,
  title = nil,
  title_pos = "center",
  pills = true,
  icons = {
    cmd = " ",
    config = "",
    debug = "● ",
    event = " ",
    favorite = " ",
    ft = " ",
    init = " ",
    import = " ",
    keys = " ",
    lazy = "󰒲 ",
    loaded = "●",
    not_loaded = "○",
    plugin = " ",
    runtime = " ",
    require = "󰢱 ",
    source = " ",
    start = " ",
    task = "✔ ",
    list = { "●", "➜", "★", "‒" },
  },
  browser = nil,
  throttle = 1000 / 30,
  custom_keys = {
    ["<localleader>l"] = {
      function(plugin)
        require("lazy.util").float_term({ "lazygit", "log" }, {
          cwd = plugin.dir,
        })
      end,
      desc = "Open lazygit log",
    },
    ["<localleader>i"] = {
      function(plugin)
        require("lazy.util").notify(vim.inspect(plugin), {
          title = "Inspect " .. plugin.name,
          lang = "lua",
        })
      end,
      desc = "Inspect Plugin",
    },
    ["<localleader>t"] = {
      function(plugin)
        require("lazy.util").float_term(nil, {
          cwd = plugin.dir,
        })
      end,
      desc = "Open terminal in plugin dir",
    },
  },
},

  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
--  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

