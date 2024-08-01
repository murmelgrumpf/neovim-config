vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

--local fileHistory = {}
--
--vim.keymap.set("n", "<C-space>", function()
--    local results = {}
--    local opts = {}
--    opts.include_current_session = vim.F.if_nil(opts.include_current_session, true)
--
--    local current_buffer = vim.api.nvim_get_current_buf()
--    local current_file = vim.api.nvim_buf_get_name(current_buffer)
--
--    if opts.include_current_session then
--        for _, buffer in ipairs(vim.split(vim.fn.execute ":buffers! t", "\n")) do
--            local match = tonumber(string.match(buffer, "%s*(%d+)"))
--            local open_by_lsp = string.match(buffer, "line 0$")
--            if match and not open_by_lsp then
--                local file = vim.api.nvim_buf_get_name(match)
--                if vim.loop.fs_stat(file) and match ~= current_buffer then
--                    table.insert(results, file)
--                end
--            end
--        end
--    end
--
--    for _, file in ipairs(vim.v.oldfiles) do
--        local file_stat = vim.loop.fs_stat(file)
--        if file_stat and file_stat.type == "file" and not vim.tbl_contains(results, file) and file ~= current_file then
--            table.insert(results, file)
--        end
--    end
--    print(results[1])
--    for k, v in pairs(results) do
--        if fileHistory[k] ~= v then
--            fileHistory[k] = current_file
--            vim.cmd("find " .. v)
--            return
--        end
--    end
--end)
--vim.keymap.set("n", "<C-n>", "<cmd>:bnext<CR>")



vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

vim.keymap.set("n", "<leader>pld", function()
    local r, c = unpack(vim.api.nvim_win_get_cursor(0))
    vim.cmd("find ./public/translations/de.json")
    vim.cmd(string.format("call cursor(%d, %d)", r, c + 1))
end)

vim.keymap.set("n", "<leader>ple", function()
    local r, c = unpack(vim.api.nvim_win_get_cursor(0))
    vim.cmd("find ./public/translations/en.json")
    vim.cmd(string.format("call cursor(%d, %d)", r, c + 1))
end)

vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    pattern = { "*" },
    callback = function()
        if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
            vim.api.nvim_exec("normal! g'\"", false)
        end
    end
})
