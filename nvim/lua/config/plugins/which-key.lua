return{
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
        local wk = require("which-key")
        wk.setup({
            delay = 300,
            preset = "modern",
            plugins = {
                spelling = {
                    enabled = true,
                    suggestions = 20,
                },
            }
        })
    wk.add({
              -- File group
      { "<leader>f", group = "File" },
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
      { "<leader>fn", "<cmd>ene!<cr>", desc = "New File" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      
      -- Git group  
      { "<leader>g", group = "Git" },
      { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Status" },
      { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Commit" },
      { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Branches" },
      { "<leader>gp", "<cmd>Git push<cr>", desc = "Push" },
      
      -- Buffer group
      { "<leader>b", group = "Buffer" },
      { "<leader>bd", "<cmd>bdelete<cr>", desc = "Delete Buffer" },
      { "<leader>bn", "<cmd>bnext<cr>", desc = "Next Buffer" },
      { "<leader>bp", "<cmd>bprevious<cr>", desc = "Previous Buffer" },
      
      -- LSP group
      { "<leader>l", group = "LSP" },
      { "<leader>li", "<cmd>LspInfo<cr>", desc = "LSP Info" },
      { "<leader>lr", "<cmd>LspRestart<cr>", desc = "Restart LSP" },
      { "<leader>lf", function() vim.lsp.buf.format { async = true } end, desc = "Format" },
      { "<leader>ld", "<cmd>Telescope lsp_definitions<cr>", desc = "Definitions" },
      { "<leader>lR", "<cmd>Telescope lsp_references<cr>", desc = "References" },
      { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
      { "<leader>lw", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace Symbols" },
      
      -- Diagnostics
      { "<leader>d", group = "Diagnostics" },
      { "<leader>dd", vim.diagnostic.open_float, desc = "Show Diagnostic" },
      { "<leader>dn", vim.diagnostic.goto_next, desc = "Next Diagnostic" },
      { "<leader>dp", vim.diagnostic.goto_prev, desc = "Prev Diagnostic" },
      { "<leader>dl", "<cmd>Telescope diagnostics<cr>", desc = "List Diagnostics" },
      
      -- Code actions (these work when LSP is active)
      { "<leader>c", group = "Code" },
      { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Actions" },
      { "<leader>cr", vim.lsp.buf.rename, desc = "Rename" },
    })
    end,
}
