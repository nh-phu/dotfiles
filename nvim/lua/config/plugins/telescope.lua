return {
    {   'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        lazy = true,
        priority = 500,
        event = "VeryLazy",
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
            -- Optional but recommended extensions
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            'nvim-tree/nvim-web-devicons',
            'lewis6991/gitsigns.nvim',
        },

        config = function()
            local telescope = require('telescope')
            local actions = require('telescope.actions')
            local builtin = require('telescope.builtin')
            telescope.setup({
                defaults = {
                    -- Appearance
                    prompt_prefix = "🔍 ",
                    selection_caret = "➤ ",
                    entry_prefix = "  ",
                    initial_mode = "insert",

                    -- Layout
                    layout_strategy = "horizontal",
                    layout_config = {
                        horizontal = {
                            prompt_position = "top",
                            preview_width = 0.55,
                            results_width = 0.8,
                        },
                        vertical = {
                            mirror = false,
                        },
                        width = 0.87,
                        height = 0.80,
                        preview_cutoff = 120,
                    },

                    -- Behavior
                    file_ignore_patterns = {
                        "node_modules",
                        ".git/",
                        "%.o",
                        "%.a",
                        "%.out",
                        "%.class",
                        "%.pdf",
                        "%.mkv",
                        "%.mp4",
                        "%.zip"
                    },

                    -- Sorting and filtering
                    sorting_strategy = "ascending",
                    file_sorter = require("telescope.sorters").get_fuzzy_file,
                    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,

                    -- Key mappings inside telescope
                    mappings = {
                        i = {
                            -- ["<C-n>"] = actions.cycle_history_next,
                            -- ["<C-p>"] = actions.cycle_history_prev,
                            ["<C-n>"] = actions.move_selection_next,
                            ["<C-p>"] = actions.move_selection_previous,
                            ["<C-c>"] = actions.close,
                            ["<CR>"] = actions.select_default,
                            ["<C-x>"] = actions.select_horizontal,
                            ["<C-v>"] = actions.select_vertical,
                            ["<C-t>"] = actions.select_tab,
                            ["<C-u>"] = actions.preview_scrolling_up,
                            ["<C-d>"] = actions.preview_scrolling_down,
                            ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                        },
                        n = {
                            ["<esc>"] = actions.close,
                            ["<CR>"] = actions.select_default,
                            ["<C-x>"] = actions.select_horizontal,
                            ["<C-v>"] = actions.select_vertical,
                            ["<C-t>"] = actions.select_tab,
                            ["j"] = actions.move_selection_next,
                            ["k"] = actions.move_selection_previous,
                            ["H"] = actions.move_to_top,
                            ["M"] = actions.move_to_middle,
                            ["L"] = actions.move_to_bottom,
                            ["<C-u>"] = actions.preview_scrolling_up,
                            ["<C-d>"] = actions.preview_scrolling_down,
                            ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                        },
                    },
                },

                -- Specific picker configurations
                pickers = {
                    find_files = {
                        theme = "dropdown",
                        previewer = false,
                        hidden = true, -- Show hidden files
                    },
                    live_grep = {
                        additional_args = function(opts)
                            return { "--hidden" }
                        end
                    },
                    buffers = {
                        theme = "dropdown",
                        previewer = false,
                        initial_mode = "normal",
                        mappings = {
                            i = {
                                ["<C-d>"] = actions.delete_buffer,
                            },
                            n = {
                                ["dd"] = actions.delete_buffer,
                            },
                        },
                    },
                    help_tags = {
                        theme = "ivy",
                    },
                },

                -- Extensions
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    }
                }
            })

            -- Load extensions
            telescope.load_extension('fzf')

            -- Essential keymaps
            local builtin = require('telescope.builtin')

            -- File navigation
            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
            vim.keymap.set('n', '<C-f>', builtin.git_files, {})
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find buffers' })
            vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Recent files' })

            -- Search
            vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Find word under cursor' })
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help tags' })

            -- LSP (if you have LSP setup)
            vim.keymap.set('n', '<leader>lr', builtin.lsp_references, { desc = 'LSP references' })
            vim.keymap.set('n', '<leader>ld', builtin.lsp_definitions, { desc = 'LSP definitions' })
            vim.keymap.set('n', '<leader>ls', builtin.lsp_document_symbols, { desc = 'Document symbols' })
            vim.keymap.set('n', '<leader>lw', builtin.lsp_workspace_symbols, { desc = 'Workspace symbols' })

            -- Utility
            vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = 'Commands' })
            vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Keymaps' })
            vim.keymap.set('n', '<leader>fo', builtin.vim_options, { desc = 'Vim options' })
        end,
    }
}
