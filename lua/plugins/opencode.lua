return {
    "nickjvandyke/opencode.nvim",
    version = "*", -- Latest stable release
    dependencies = {
        {
            -- `snacks.nvim` integration is recommended, but optional
            ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
            "folke/snacks.nvim",
            opts = {
                input = {}, -- Enhances `ask()`
                picker = {  -- Enhances `select()`
                    actions = {
                        opencode_send = function(...) return require("opencode").snacks_picker_send(...) end,
                    },
                    win = {
                        input = {
                            keys = {
                                ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
                            },
                        },
                    },
                },
            },
        },
    },
    config = function()
        ---@type opencode.Opts
        vim.g.opencode_opts = {
            -- Your configuration, if any; goto definition on the type or field for details
        }

        vim.o.autoread = true -- Required for `opts.events.reload`

        -- Recommended/example keymaps
        vim.keymap.set({ "n", "x" }, "<C-s>", function() require("opencode").ask("", { submit = true }) end,
            { desc = "Ask opencode…" })
        vim.keymap.set({ "n", "x" }, "<C-x>", function() require("opencode").select() end,
            { desc = "Execute opencode action…" })
        vim.keymap.set({ "n", "x" }, "<C-n>", function() require("opencode").toggle() end,
            { desc = "Toggle opencode" })
    end,
}
