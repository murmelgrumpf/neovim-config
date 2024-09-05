vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.api.nvim_create_autocmd({ "BufCreate", "BufEnter", "SessionLoadPost" },
    {
        pattern = { "*.xml" },
        callback = function()
            vim.cmd("setlocal expandtab noexpandtab")
            vim.cmd("setlocal nofixendofline nofixendofline")
        end
    }
)

vim.opt.smartindent = true

vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "120"

vim.opt.autoread = true
vim.g.focus_event = true

vim.api.nvim_create_autocmd("FocusGained", { pattern = ("*"), command = "checktime", })
vim.api.nvim_create_autocmd("CursorHold", { pattern = ("*"), command = "checktime", })
vim.api.nvim_create_autocmd("FileChangedShell", { pattern = ("*"), command = "checktime", })

vim.opt.listchars = "eol:$,tab:>-,trail:~,extends:>,precedes:<,space:␣"
