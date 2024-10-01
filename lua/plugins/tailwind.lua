-- tailwind-tools.lua
return {
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    build = ":UpdateRemotePlugins",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-telescope/telescope.nvim",
        "neovim/nvim-lspconfig",
    },
    opts = {
        conceal = {
            enabled = true, -- can be toggled by commands
        },
    },
    config = function()
        vim.api.nvim_create_autocmd({ "BufWritePre" }, {
            pattern = { "*.templ" },
            callback = function()
                vim.api.nvim_exec("TailwindSortSync", false)
            end
        })
    end
}
