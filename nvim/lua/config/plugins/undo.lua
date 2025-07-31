return {
  "mbbill/undotree",
  config = function()
    vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Undo tree" })
    -- Undotree configuration
    vim.g.undotree_WindowLayout = 4       -- Layout: undotree on left, diff on bottom
    vim.g.undotree_SplitWidth = 28        -- Width of undotree window
    vim.g.undotree_DiffpanelHeight = 10   -- Height of diff panel
    vim.g.undotree_SetFocusWhenToggle = 1 -- Focus undotree when toggled
    vim.g.undotree_ShortIndicators = 1    -- Use short indicators
    vim.g.undotree_HelpLine = 0           -- Hide help line
    vim.g.undotree_DiffAutoOpen = 1
  end,
}
