vim.api.nvim_create_user_command('W', "execute ':silent w !sudo tee % > /dev/null' | :edit!", {})

vim.api.nvim_create_user_command('SS', ':set list!', {})
vim.api.nvim_create_user_command('PS', ':%s/    /	/g', {})
vim.api.nvim_create_user_command('PT', ':%s/	/    /g', {})
