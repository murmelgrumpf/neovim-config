return {
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        -- stylua: ignore
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
            { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
            { "r", mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
            { "R", mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        },
        config = function()
            require("flash").setup({
                label = {
                    rainbow = {
                        enabled = true,
                        -- number between 1 and 9
                        shade = 9,
                    },
                },
                modes = {
                    search = {
                        enabled = true,
                    }
                }
            })
        end
    }
}
