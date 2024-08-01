local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
    return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
require("mason").setup()

null_ls.setup({
    on_attach = function(client)
        if client.resolved_capabilities.document_formatting then
            vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
        end
    end,
    debounce = 50,
    debounce_text_changes = 50,
    update_in_insert = true,
    root_dir = require("null-ls.utils").root_pattern(".git", "package.json"),
})

require('mason-null-ls').setup({
    ensure_installed = { 'eslint_d', 'prettierd' },
    handlers = {
        function() end, -- disables automatic setup of all null-ls sources
        eslint_d = function(source_name, methods)
            null_ls.register(formatting.eslint_d)
            null_ls.register(diagnostics.eslint_d.with({ diagnostic_config = { underline = true, update_in_insert = true } }))
        end,
        prettierd = function(source_name, methods)
            null_ls.register(formatting.prettierd.with({
                filetypes = { "handlebars" }

            }))
        end,

    },
})
