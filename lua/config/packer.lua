return require('packer').startup(function(use)
    use {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        requires = { { "nvim-lua/plenary.nvim" } }
    }

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
    }

    use({
        "nvimtools/none-ls.nvim",
        config = function()
            require("null-ls").setup()
        end,
        requires = {
            { "nvim-lua/plenary.nvim" },
            { "jay-babu/mason-null-ls.nvim" },
        },
    })

    use {
        'rmagatti/auto-session',
    }
end)
