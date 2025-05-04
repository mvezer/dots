-- options
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.o.cmdheight = 0
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "auto:4"
vim.o.mouse = "a" -- enable mouse
vim.o.clipboard = "unnamedplus"
vim.o.breakindent = true
vim.o.undofile = true -- persist undo
vim.o.ignorecase = true
vim.o.hlsearch = true
vim.o.smartcase = true
vim.o.updatetime = 250
vim.o.timeoutlen = 300
-- vim.o.completeopt = "menuone,noselect"
vim.o.completeopt = "menu,noinsert,popup,fuzzy"
vim.o.termguicolors = true
vim.o.hidden = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.expandtab = true
vim.o.softtabstop = 2
-- vim.opt.list = true
-- vim.opt.formatoptions:remove({ "r", "o" })
vim.opt.cursorline = true
-- vim.g.netrw_banner = 1 -- BUG: the screen is flickering when banner is off (https://github.com/neovim/neovim/issues/23650)
vim.cmd([[autocmd FileType * set formatoptions-=ro]]) -- disable new line auto comment

require "plugins"
require "lsp"
require "keymap"

