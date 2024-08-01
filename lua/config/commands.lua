vim.api.nvim_create_user_command('W', "execute ':silent w !sudo tee % > /dev/null' | :edit!", {})
