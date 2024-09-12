return {
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            "nvim-telescope/telescope-live-grep-args.nvim",
            {
                "isak102/telescope-git-file-history.nvim",
                dependencies = { "tpope/vim-fugitive" }
            },
        },
        config = function()
            require("telescope").load_extension("live_grep_args")
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "TelescopeResults",
                callback = function(ctx)
                    vim.api.nvim_buf_call(ctx.buf, function()
                        vim.fn.matchadd("TelescopeParent", "\t\t.*$")
                        vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
                    end)
                end,
            })

            local function filenameFirst(_, path)
                local tail = vim.fs.basename(path)
                local parent = vim.fs.dirname(path)
                if parent == "." then return tail end
                return string.format("%s\t\t%s", tail, parent)
            end

            require("telescope").setup {
                pickers = {
                    find_files = {
                        path_display = filenameFirst,
                    },
                    live_grep = {
                        path_display = filenameFirst,
                    },
                    oldfiles = {
                        path_display = filenameFirst,
                    }
                }
            }

            local builtin = require('telescope.builtin')

            vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
            vim.keymap.set('n', '<C-p>', require("telescope").extensions.git_file_history.git_file_history, {})
            vim.keymap.set('n', '<leader>ps', function()
                require("telescope").extensions.live_grep_args.live_grep_args({
                    additional_args = { '--max-filesize', '1G' },
                    path_display =
                        filenameFirst
                });
            end)
            require("telescope").load_extension("noice")

            -- vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
            -- require("telescope").load_extension("session-lens")
            -- require("auto-session").setup {
            --     log_level = vim.log.levels.ERROR,
            --     auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
            --     auto_session_use_git_branch = false,
            --
            --     auto_save_enabled = true,
            --     auto_session_enabled = true,
            --
            --     auto_session_enable_last_session = false,
            --     --, "!prettierd restart"
            --     --auto_session_create_enabled = true,
            --     session_lens = {
            --         buftypes_to_ignore = {}, -- list of buffer types what should not be deleted from current session
            --         load_on_setup = true,
            --         theme_conf = { border = true },
            --         previewer = false,
            --     },
            -- }
            --
            -- vim.keymap.set("n", "<C-s>", function(...)
            --     vim.cmd "wa"
            --     require("auto-session.session-lens").search_session(...)
            -- end, {
            --     noremap = true,
            -- })
        end,
    }
}
