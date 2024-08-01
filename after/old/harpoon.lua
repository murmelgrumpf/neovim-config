local harpoon = require("harpoon")
local Path = require("plenary.path")

local function normalize_path(buf_name, root)
    return Path:new(buf_name):make_relative(root)
end

-- REQUIRED
config = harpoon:setup().config
-- REQUIRED

vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-y>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)

vim.api.nvim_create_autocmd({ "BufEnter" },
    {
        pattern = { "*.ts", "*.hbs" },
        callback = function()
            local path = normalize_path(
                vim.api.nvim_buf_get_name(
                    vim.api.nvim_get_current_buf()
                ),
                vim.loop.cwd()
            )
            if string.find(path, "\\templates\\") or string.find(path, "\\routes\\") or string.find(path, "\\controllers\\") then
                local list = harpoon:list()
                list:clear()
                local genericPath = path:gsub("\\templates\\", "\\COOLTEMPPATHTHINGY\\"):gsub("%.hbs", "FILEEND")
                genericPath = genericPath:gsub("\\routes\\", "\\COOLTEMPPATHTHINGY\\"):gsub("%.ts", "FILEEND")
                genericPath = genericPath:gsub("\\controllers\\", "\\COOLTEMPPATHTHINGY\\")
                list:append(list.config.create_list_item(list.config,
                    genericPath:gsub("COOLTEMPPATHTHINGY", "controllers"):gsub("FILEEND", ".ts")))
                list:append(list.config.create_list_item(list.config,
                    genericPath:gsub("COOLTEMPPATHTHINGY", "templates"):gsub("FILEEND", ".hbs")))
                list:append(list.config.create_list_item(list.config,
                    genericPath:gsub("COOLTEMPPATHTHINGY", "routes"):gsub("FILEEND", ".ts")))
                harpoon:sync()
            end
            if string.find(path, "\\components\\") then
                local list = harpoon:list()
                list:clear()
                local genericPath = path:gsub("%.ts", "FILEEND"):gsub("%.hbs", "FILEEND")
                list:append(list.config.create_list_item(list.config, genericPath:gsub("FILEEND", ".ts")))
                list:append(list.config.create_list_item(list.config, genericPath:gsub("FILEEND", ".hbs")))
                harpoon:sync()
            end
        end,
    })

vim.api.nvim_create_autocmd({ "BufEnter" },
    {
        pattern = { "de.json", "en.json" },
        callback = function()
            local path = normalize_path(
                vim.api.nvim_buf_get_name(
                    vim.api.nvim_get_current_buf()
                ),
                vim.loop.cwd()
            )
            local list = harpoon:list()
            list:clear()
            local genericPath = path:gsub("de.json", "FILEEND"):gsub("en.json", "FILEEND")
            list:append(list.config.create_list_item(list.config, genericPath:gsub("FILEEND", "de.json")))
            list:append(list.config.create_list_item(list.config, genericPath:gsub("FILEEND", "en.json")))
            harpoon:sync()
        end,
    })
