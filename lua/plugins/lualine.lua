return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup {
                options = {
                    icons_enabled = true,
                    theme = 'auto',
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    globalstatus = false,
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                    },


                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch', function()
                        it = string.gmatch(require('auto-session.lib').current_session_name(), "([^-]+)")
                        result = ""
                        last = ""
                        for s in it do
                            if s ~= nil then
                                if last == "workspace" or last == "Local" then
                                    result = s
                                else
                                    result = last .. [[-]] .. s
                                end
                            end
                            last = s
                        end
                        return result
                    end },
                    lualine_c = {
                        function()
                            path = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
                            if string.find(path, "\\templates\\") then
                                return "Template"
                            elseif string.find(path, "\\routes\\") then
                                return "Route"
                            elseif string.find(path, "\\controllers\\") then
                                return "Controller"
                            elseif string.find(path, "\\components\\") then
                                return "Component"
                            end
                        end,
                        { 'filename', symbols = { modified = ' ' } },
                        {
                            require("noice").api.statusline.mode.get,
                            cond = require("noice").api.statusline.mode.has,
                            color = { fg = "#ff9e64" },
                        },

                    },
                    lualine_x = {
                        {
                            'diagnostics',
                            sections = { 'error', 'warn', 'info', 'hint' },
                            symbols = { error = '󱈸󱈸󱈸 ERROR ', warn = '  󱈸󱈸 WARNING ', info = '  INFO ', hint = '  HINT ' },
                            colored = true,
                            separator = { left = "f" },
                            padding = { right = 30 },
                            diagnostics_color = {
                                error = { gui = 'bold' },
                                warn  = { gui = 'bold' },
                            },
                        },
                        'encoding', 'fileformat', 'filetype' },
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' }
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { 'filename' },
                    lualine_x = { 'location' },
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = {}
            }

            --vim.cmd [[Guifont! SauceCodePro Nerd Font]]
        end,
    }
}
