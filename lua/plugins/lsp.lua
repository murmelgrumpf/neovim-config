return {
    {
        "williamboman/mason.nvim",
        config = function()
            require('mason').setup({})
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require('mason-lspconfig').setup({
                ensure_installed = {
                    'lua_ls',
                    'bashls',
                    'jdtls',
                    'stylelint_lsp',
                    'ember',
                    'gopls',
                    'cssls',
                    'css_variables',
                    'htmx',
                    'templ',
                    'html',
                    'tailwindcss',
                },
            })
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        config = function()
            require('mason-tool-installer').setup({
                ensure_installed = { 'java-debug-adapter' },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            vim.diagnostic.config({
                update_in_insert = true,
            })

            vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

            --local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
            local lsp_cabilities = vim.lsp.protocol.make_client_capabilities()
            local lspconfig = require('lspconfig')
            --lsp_capabilities.textDocument.completion.completionItem.snippetSupport = true;

            lspconfig.lua_ls.setup({
                capabilities = lsp_capabilities,
                settings = {
                    Lua = {
                        runtime = {
                            -- Tell the language server which version of Lua you're using
                            -- (most likely LuaJIT in the case of Neovim)
                            version = 'LuaJIT',
                        },
                        diagnostics = {
                            -- Get the language server to recognize the `vim` global
                            globals = {
                                'vim',
                                'require'
                            },
                        },
                        workspace = {
                            -- Make the server aware of Neovim runtime files
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                        -- Do not send telemetry data containing a randomized but unique identifier
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            })

            lspconfig.stylelint_lsp.setup({
                capabilities = lsp_capabilities,
                settings = {
                    stylelintplus = {
                        autoFixOnFormat = true,
                        autoFixOnSave = true,
                    }
                },
                filetypes = { "css", "less", "scss", "sugarss", "vue", "wxss" }
            })
            lspconfig.cssls.setup({
                capabilities = lsp_capabilities,
            })

            lspconfig.css_variables.setup({
                capabilities = lsp_capabilities,
                embeddedLanguages = {
                    css = true,
                    javascript = true
                },
            })

            lspconfig.html.setup({
                capabilities = lsp_capabilities,
                filetypes = { "html", "templ" },
            })

            lspconfig.htmx.setup({
                capabilities = lsp_capabilities,
                filetypes = { "html", "templ" },
            })

            lspconfig.templ.setup({
                capabilities = lsp_capabilities,
            })

            lspconfig.tsserver.setup({
                capabilities = lsp_capabilities,
                on_init = function(client)
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentFormattingRangeProvider = false
                end,
            })

            lspconfig.ember.setup({
                capabilities = lsp_capabilities,
            })

            lspconfig.gopls.setup({
                capabilities = lsp_capabilities,
            })

            lspconfig.bashls.setup {
                capabilities = lsp_capabilities,
                filetypes = { "sh", "zsh", "bash" },
            }


            vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end)
            vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end)
            vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end)
            vim.keymap.set("n", "<leader>vs", function() vim.lsp.buf.workspace_symbol() end)
            vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end)
            vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end)
            vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end)
            vim.keymap.set("n", "<leader>da", function() vim.lsp.buf.code_action() end)
            vim.keymap.set("n", "<leader>dr", function() vim.lsp.buf.rename() end)
            vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end)
        end,
    },
    {
        'nvimtools/none-ls.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        config = function()
            local null_ls = require('null-ls')

            null_ls.setup({
                on_attach = function(client)
                    if client.server_capabilities.document_formatting then
                        vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
                    end
                end,
                debounce = 50,
                debounce_text_changes = 50,
                update_in_insert = true,
                root_dir = require("null-ls.utils").root_pattern(".git", "package.json"),
            })
        end,
    },
    {
        'jay-babu/mason-null-ls.nvim',
        dependencies = {
            "williamboman/mason.nvim",
            "nvimtools/none-ls.nvim",
            "nvimtools/none-ls-extras.nvim",
        },
        config = function()
            local null_ls = require('null-ls')

            local formatting = null_ls.builtins.formatting
            local diagnostics = null_ls.builtins.diagnostics

            require('mason-null-ls').setup({
                ensure_installed = { 'eslint_d', 'prettierd' },
                handlers = {
                    function() end, -- disables automatic setup of all null-ls sources
                    eslint_d = function(source_name, methods)
                        null_ls.register(require("none-ls.formatting.eslint_d"))
                        null_ls.register(require("none-ls.diagnostics.eslint_d").with({ diagnostic_config = { underline = true, update_in_insert = true } }))
                    end,
                    prettierd = function(source_name, methods)
                        null_ls.register(formatting.prettierd.with({
                            filetypes = { "handlebars" }
                        }))
                    end,
                },
                automatic_installation = true,
            })
        end,
    },
    --    {
    --        'hrsh7th/nvim-cmp',
    --        config = function()
    --            local cmp = require('cmp')
    --            local cmp_select = { behavior = cmp.SelectBehavior.Select }
    --
    --            cmp.setup({
    --                sources = {
    --                    { name = 'path' },
    --                    --{ name = 'nvim_lsp' },
    --                    --{ name = 'nvim_lua' },
    --                    --{ name = 'luasnip', keyword_length = 2 },
    --                    { name = 'buffer', keyword_length = 1 },
    --                },
    --                mapping = cmp.mapping.preset.insert({
    --                    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    --                    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    --                    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    --                    ['<C-Space>'] = cmp.mapping.complete(),
    --                }),
    --            })
    --
    -- `/` cmdline setup.
    --cmp.setup.cmdline('/', {
    --    mapping = cmp.mapping.preset.cmdline(),
    --    sources = {
    --        { name = 'buffer' }
    --    }
    --})

    ---- `:` cmdline setup.
    --cmp.setup.cmdline(':', {
    --    mapping = cmp.mapping.preset.cmdline(),
    --    sources = cmp.config.sources({
    --        { name = 'path' }
    --    }, {
    --        {
    --            name = 'cmdline',
    --            option = {
    --                ignore_cmds = { 'Man', '!' }
    --            }
    --        }
    --    })
    --})
    --end,
    --},
    --{ 'hrsh7th/cmp-buffer' },
    --{ 'hrsh7th/cmp-path' },
    --{ 'hrsh7th/cmp-nvim-lua' },
    --{ 'hrsh7th/cmp-nvim-lsp' },
    --{ 'hrsh7th/cmp-cmdline' },
    --{ 'L3MON4D3/LuaSnip' },
    --{ 'rafamadriz/friendly-snippets' },
    --{ 'saadparwaiz1/cmp_luasnip' },
}
