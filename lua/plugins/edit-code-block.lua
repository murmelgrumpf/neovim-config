return {
    {
        "dawsers/edit-code-block.nvim",
        config = function()
            require('ecb').setup {
                wincmd = 'tabnew', -- this is the default way to open the code block window
            }
        end,
    },
}
