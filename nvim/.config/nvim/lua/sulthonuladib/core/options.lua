vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.nu = true
opt.relativenumber = true
opt.showmode = false
opt.showcmd = true
-- opt.cmdheight = 1 -- Height of the command bar
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartcase = true
opt.breakindent = true
opt.wrap = false
opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true
opt.hlsearch = false
opt.incsearch = true
opt.scrolloff = 8
opt.signcolumn = "yes"
opt.smoothscroll = true
opt.cursorline = true
opt.colorcolumn = "80"
opt.inccommand = "split"
opt.winborder = "single"
opt.termguicolors = true
vim.o.title = true
opt.titlestring = vim.fn.fnamemodify(vim.fn.getcwd(), ":t") .. " - nvim"
opt.viminfo:remove("m")
