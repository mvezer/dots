vim.g.mapleader = " "

vim.g.maplocalleader = " "
vim.o.cmdheight = 0
vim.o.hlsearch = true

vim.o.number = false
vim.o.signcolumn = "auto:4"
vim.o.guicursor =
	"n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

-- Enable mouse mode
vim.o.mouse = "a"

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = "unnamedplus"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 500

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.o.hidden = true

vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.expandtab = true
vim.o.softtabstop = 2
-- vim.opt.listchars = { tab = " " }
vim.opt.list = true

vim.opt.formatoptions:remove({ "r", "o" })
vim.g.disable_autoformat = true
vim.b.copilot_suggestion_auto_trigger = false
vim.g.copilot_suggestion_auto_trigger = false

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

OS = vim.loop.os_uname().sysname

vim.g.sql_type_default = "pgsql"
NOTES_DIR = os.getenv("NOTES_DIR") or os.getenv("HOME") .. "/notes"

