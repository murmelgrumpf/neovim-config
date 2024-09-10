vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*.java" },
    callback = function()
        vim.api.nvim_exec("PE", false)
    end
})
