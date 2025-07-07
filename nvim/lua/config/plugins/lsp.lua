return {
    -- Mason (LSP installer) - should come first
    { "williamboman/mason.nvim", build = ":MasonUpdate", config = true },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",  -- Lua
                    "clangd",  -- C/C++
                    "pyright", -- Python (or "pylsp" for alternative)
                    "bashls", -- Bash
                    "rust_analyzer" -- Rust
                },
                automatic_installation = true,
            })
        end
    },

    -- LSP Setup (language servers)
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- Lua LSP
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            })

            -- C/C++ LSP (clangd)
            lspconfig.clangd.setup({
                capabilities = capabilities,
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--header-insertion=iwyu",
                    "--completion-style=detailed",
                    "--function-arg-placeholders",
                    "--fallback-style=llvm",
                },
                init_options = {
                    usePlaceholders = true,
                    completeUnimported = true,
                    clangdFileStatus = true,
                },
            })

            -- Python LSP (pyright)
            lspconfig.pyright.setup({
                capabilities = capabilities,
                settings = {
                    python = {
                        analysis = {
                            autoSearchPaths = true,
                            diagnosticMode = "workspace",
                            useLibraryCodeForTypes = true,
                        },
                    },
                },
            })

            -- Global LSP keymaps
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    local opts = { buffer = ev.buf }
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
                    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                    vim.keymap.set('n', '<leader>f', function()
                        vim.lsp.buf.format { async = true }
                    end, opts)
                end,
            })
        end
    },

    -- Autocompletion with Copilot integration
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip",
            "zbirenbaum/copilot-cmp", -- Copilot integration for nvim-cmp
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                completion = {
                    autocomplete = false,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if luasnip.jumpable() then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<CR>"] = cmp.mapping(function(fallback)
                        if cmp.visible() and cmp.get_active_entry() then
                            cmp.confirm({ select = false }) -- Only confirm if explicitly selected
                        else
                            fallback()                      -- Normal enter behavior
                        end
                    end),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-n>"] = cmp.mapping.select_next_item(),         -- Ctrl+n to navigate down
                    ["<C-p>"] = cmp.mapping.select_prev_item(),         -- Ctrl+p to navigate up
                    ["<C-f>"] = cmp.mapping.confirm({ select = true }), -- Ctrl+y to accept
                    ["<C-e>"] = cmp.mapping.abort(),                    -- Ctrl+e to close
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp", priority = 900 },
                    { name = "copilot",  priority = 800 },
                    { name = "luasnip",  priority = 700 },
                }, {
                    { name = "buffer", priority = 600 },
                    { name = "path",   priority = 500 },
                }),
                formatting = {
                    format = function(entry, vim_item)
                        -- Add source indicators
                        vim_item.menu = ({
                            copilot = "[Copilot]",
                            nvim_lsp = "[LSP]",
                            luasnip = "[Snippet]",
                            buffer = "[Buffer]",
                            path = "[Path]",
                        })[entry.source.name]
                        return vim_item
                    end,
                },
            })
        end,
    },
}
