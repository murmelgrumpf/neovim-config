vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*.templ" },
    callback = function()
        vim.api.nvim_exec("TailwindSortSync", false)
    end
})
