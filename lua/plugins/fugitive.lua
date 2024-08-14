return {
    {
        'tpope/vim-fugitive',
        dependencies = {
            'junegunn/gv.vim',
            'tpope/vim-rhubarb'
        },
        config = function()
            vim.keymap.set("n", "<leader>gs", vim.cmd.Git);
            vim.keymap.set("n", "<leader>gg", "<cmd>GV --all<cr>");
            vim.keymap.set("n", "<leader>ga", [[<cmd>GV --name-status --all --format=%ad\ %h%d\ %sr\ (%an)\ %b<cr>]]);
            vim.keymap.set("n", "<leader>gb", "<cmd>Git blame<cr>");
        end,
    }
}
