return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd('colorscheme tokyonight-storm')
            vim.cmd('highlight LineNr guifg=#b6bef0')
            vim.cmd('highlight LineNrBelow guifg=#9aa1cc')
            vim.cmd('highlight LineNrAbove guifg=#9aa1cc')
        end
    }
}
