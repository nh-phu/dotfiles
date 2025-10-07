vim.o.updatetime = 50
vim.opt.termguicolors = true
--set keymap for common actions
vim.keymap.set("x", "<leader>p", "\"_dP")
vim.api.nvim_set_keymap('n', '<leader>q', ':bd<CR>', { noremap = true })
--vim.api.nvim_set_keymap('i', '<Esc>', '<Esc>', { noremap = true, silent = true })
vim.opt.mouse = "a";
vim.opt.gcr = "a:blinkon0"
vim.opt.ignorecase = false
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.showmode = false

vim.opt.wrapscan = true
vim.opt.swapfile = false

-- Set up basic options for Neovim
vim.opt.colorcolumn = "80"

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.cursorline = false
vim.opt.cursorlineopt = "number"

vim.opt.termguicolors = true

vim.opt.laststatus = 2

vim.opt.showmatch = false

vim.opt.hlsearch = true

vim.opt.incsearch = true

-- Use a nice default tab width
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.showmode = false

-- File type specific indentation
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua", "javascript", "typescript", "json", "yaml", "html", "css" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end
})

-- Keep 4 spaces for C, C++, and other languages
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "java", "python", "bash", "sh", "zsh", "rust" },
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
  end
})

-- Enable clipboard integration
--vim.opt.clipboard = "unnamedplus"
vim.api.nvim_set_hl(0, "LspReferenceText", { bg = "#363944" })
vim.api.nvim_set_hl(0, "LspReferenceRead", { bg = "#363944" })
vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = "#3e4452" })

-- Bufferline settings
vim.keymap.set('n', '<A-j>', '<cmd>bnext<cr>', { silent = true })
vim.keymap.set('n', '<A-k>', '<cmd>bprev<cr>', { silent = true })
vim.keymap.set('n', '<A-Tab>', '<cmd>b#<cr>', { silent = true })
vim.keymap.set('n', '<leader>bb', '<cmd>Telescope buffers<cr>',
  { noremap = true, silent = true })
vim.opt.wrap = false
vim.opt.scrolloff = 4

-- Undo
vim.opt.undofile = true                             -- Enable persistent undo
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo" -- Set undo directory
vim.opt.undolevels = 10000                          -- Maximum number of changes that can be undone
vim.opt.undoreload = 10000                          -- Maximum number lines to save for undo on buffer reload

-- Create undo directory if it doesn't exist
local undo_dir = vim.fn.stdpath("data") .. "/undo"
if vim.fn.isdirectory(undo_dir) == 0 then
  vim.fn.mkdir(undo_dir, "p")
end

-- Highlight yanked text briefly using the Visual highlight group
-- vim.api.nvim_create_autocmd("TextYankPost", {
--   desc = "Highlight when yanking text",
--   group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
--   callback = function()
--     vim.hl.on_yank()
--   end,
-- })

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    (vim.hl or vim.highlight).on_yank()
  end,
})

-- Disable relative numbers in insert mode
--[[ vim.api.nvim_create_autocmd({"InsertEnter"}, {
  callback = function()
    vim.opt.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd({"InsertLeave"}, {
  callback = function()
    vim.opt.relativenumber = true
  end,
}) ]]

require("config.lazy")
vim.lsp.enable({'clangd', 'rust-analyzer', 'lua_ls', 'bashls', 'pyright', 'copilot', 'jdtls'})
-- LSP completion trigger

--[[ vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = false })
      vim.keymap.set('i', '<c-space>', function()
        vim.lsp.completion.get()
      end)
    end
  end,
}) ]]

vim.diagnostic.config({
  -- Use the default configuration
  virtual_lines = false

  -- Alternatively, customize specific options
  -- virtual_lines = {
  --  -- Only show virtual line diagnostics for the current cursor line
  --  current_line = true,
  -- },
})
