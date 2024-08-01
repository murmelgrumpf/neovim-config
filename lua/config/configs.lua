vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        update_in_insert = true,
    }
)

vim.opt.autoread = true
vim.g.focus_event = true

vim.autocmd("FocusGained", { pattern = ("*"), command = "checktime", })

--vim.filetype.add {
--    extension = {
--        zsh = "sh",
--        sh = "sh", -- force sh-files with zsh-shebang to still get sh as filetype
--    },
--    filename = {
--        [".zshrc"] = "sh",
--        [".zshenv"] = "sh",
--    },
--}
-- use bash-treesitter-parser for zsh
vim.api.nvim_create_augroup("zshAsBash", {})
vim.api.nvim_create_autocmd("BufWinEnter", {
    group = "zshAsBash",
    pattern = { "*.sh", "*.zsh" },
    command = "silent! set filetype=sh",
})
