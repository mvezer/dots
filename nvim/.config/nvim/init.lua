-- options
vim.g.mapleader = " "

if vim.loop.os_uname().sysname == "Linux" then
  -- vim.g.clipboard = {
  --   name = "wl-clipboard",
  --   copy = {
  --     ["+"] = "wl-copy --foreground --type text/plain",
  --     ["*"] = "wl-copy --foreground --primary --type text/plain",
  --   },
  --   paste = {
  --     ["+"] = "wl-paste --no-newline",
  --     ["*"] = "wl-paste --primary --no-newline",
  --   },
  --   cache_enabled = true,
  -- }
  vim.o.clipboard = "unnamed"
else
  vim.o.clipboard = "unnamed,unnamedplus"
end

vim.g.maplocalleader = " "
vim.o.cmdheight = 1
vim.o.number = false
-- vim.o.relativenumber = true
vim.o.signcolumn = "auto:4"
vim.o.mouse = "a"     -- enable mouse
vim.o.breakindent = true
vim.o.undofile = true -- persist undo
vim.o.ignorecase = true
vim.o.hlsearch = true
vim.o.smartcase = true
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.completeopt = "menu,noinsert,popup,fuzzy"
vim.o.termguicolors = true
vim.o.hidden = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.expandtab = true
vim.o.softtabstop = 2
-- vim.opt.listchars = { tab = " " }
vim.opt.list = true
vim.opt.listchars = {
  tab = "→ ",
  space = "·",
  -- eol = "↵",
  -- trail = "~",
  -- extends = ">",
  -- precedes = "<",
}
-- vim.o.messagesopt = "wait:3000,history:500"
vim.opt.cursorline = true
-- vim.g.netrw_banner = 1 -- BUG: the screen is flickering when banner is off (https://github.com/neovim/neovim/issues/23650)
vim.cmd([[autocmd FileType * set formatoptions-=ro]]) -- disable new line auto comment
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
-- vim.opt.grepprg = "rg --vimgrep -uu"

require("plugins")
require("lsp")
require("keymap")
require("autocmds")

-- TODOs
-- [x] disable enter in popupmenu
-- [x] find a way to use fzf-lua with avante file selector or set up neovtree for that (https://github.com/yetone/avante.nvim?tab=readme-ov-file#neotree-shortcut)
-- [x] autoformat on save
-- obsidian plugin (or something similar)
