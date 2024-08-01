local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    lsp_zero.buffer_autoformat()
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vs", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>va", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)
local get_java_root_dir = function()
    local d = vim.fs.dirname(vim.fs.find({ '.gradlew', '.git', 'mvnw' }, { upward = true })[1])
    return d
end

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = { 'lua_ls', 'stylelint_lsp', 'jdtls', 'tsserver', 'ember', 'gopls' },
    handlers = {
        lsp_zero.default_setup,
        lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
        end,
        stylelint_lsp = function()
            require('lspconfig').stylelint_lsp.setup({
                settings = {
                    stylelintplus = {
                        autoFixOnFormat = true,
                        autoFixOnSave = true,
                    }
                },
                filetypes = { "css", "less", "scss", "sugarss", "vue", "wxss" }
            })
        end,
        jdtls = function()
            require('lspconfig').jdtls.setup({
                cmd = {
                    "jdtls",
                    "--jvm-arg=" .. string.format(
                        "-javaagent:%s",
                        require("mason-registry").get_package("jdtls"):get_install_path() .. "/lombok.jar"
                    ),
                },
                settings = {
                    java = {
                        project = {
                            sourcePaths = { "target/generated-sources/annotations" }
                        },
                        format = {
                            settings = {
                                url = ".\\eclipse-formatter.xml",
                                profile = "Aprenia"
                            }
                        }
                    },
                },
                root_dir = get_java_root_dir,
            })
        end,
        tsserver = function()
            require('lspconfig').tsserver.setup({
                on_init = function(client)
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentFormattingRangeProvider = false
                end,
            })
        end,
        bashls = function()
            require("lspconfig").bashls.setup {
                filetypes = { "sh", "zsh", "bash" },
            }
        end,
        --lemminx = function()
        --    require('lspconfig').lemminx.setup({
        --        settings = {
        --            xml = {
        --                format = {
        --                    insertSpaces = false,
        --                    splitAttributes = true,
        --                    joinCDATALines = false,
        --                    joinContentLines = false,
        --                    joinCommentLines = false,
        --                    formatComments = false,
        --                    spaceBeforeEmptyCloseTag = true,
        --                    enabled = true
        --                }
        --            }
        --        }
        --    })
        --end
    }
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'luasnip', keyword_length = 2 },
        { name = 'buffer',  keyword_length = 3 },
    },
    formatting = lsp_zero.cmp_format(),
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
    }),
})
