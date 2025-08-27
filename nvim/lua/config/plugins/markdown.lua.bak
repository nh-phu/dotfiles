return {
  -- Real-time markdown rendering (lightweight, single plugin solution)
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    opts = {
      heading = { enabled = true, sign = false },
      code = { enabled = true, style = 'normal' },
      bullet = { enabled = true },
      checkbox = { enabled = true },
    },
  },

  -- Browser preview (only when needed)
  {
    "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = "markdown",
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    config = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
    end,
  },
}
