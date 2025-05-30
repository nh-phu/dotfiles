vim.g.mapleader = " "  -- set leader to space
vim.g.maplocalleader = "\\"  -- local leader also space (optional)
vim.o.updatetime = default
require("config.lazy")
require("config.hl-yank")
vim.opt.termguicolors = true -- enable true color support
--set keymap for common actions
--vim.api.nvim_set_keymap('n', '<leader>e', ':Snacks.explorer<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>q', ':bd<CR>', { noremap = true })
vim.api.nvim_set_keymap('i', '<Esc>', '<Esc>', { noremap = true, silent = true })
vim.opt.mouse = "a"
vim.keymap.set("n", "<C-Tab>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
-- Set up basic options for Neovim

-- Show absolute line numbers + relative numbers (relative is handy for motions)
vim.opt.number = true
vim.opt.relativenumber = false

-- Highlight the current line
vim.opt.cursorline = true

-- Enable true color support (important for nice colorschemes)
vim.opt.termguicolors = true

-- Set status line style (basic)
vim.opt.laststatus = 3 -- global statusline

-- Show matching brackets instantly
vim.opt.showmatch = true

-- Highlight search results
vim.opt.hlsearch = true

-- Incremental search as you type
vim.opt.incsearch = true

-- Use a nice default tab width
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true -- spaces instead of tabs

-- Enable clipboard integration


vim.opt.clipboard = "unnamedplus"

vim.api.nvim_set_hl(0, "LspReferenceText", { bg = "#363944" })
vim.api.nvim_set_hl(0, "LspReferenceRead", { bg = "#363944" })
vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = "#3e4452" })

-- Bufferline settings
vim.keymap.set('n', '<S-l>', ':BufferLineCycleNext<CR>', { silent = true })
vim.keymap.set('n', '<S-h>', ':BufferLineCyclePrev<CR>', { silent = true })
vim.keymap.set('n', '<leader>bb', '<cmd>Telescope buffers<cr>', { noremap = true, silent = true })
vim.opt.wrap = false
vim.opt.scrolloff = 5 
