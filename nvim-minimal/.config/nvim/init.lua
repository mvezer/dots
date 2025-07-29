local o = vim.opt
local g = vim.g
g.mapleader = " "
o.clipboard = "unnamed,unnamedplus"
o.cmdheight = 1
o.number = true
o.signcolumn = "auto:4"
o.mouse = "a"
o.breakindent = true
o.undofile = true
o.ignorecase = true
o.hlsearch = true
o.smartcase = true
o.updatetime = 250
o.timeoutlen = 400
o.completeopt = "menu,noinsert,popup,fuzzy"
o.termguicolors = true
o.hidden = true
o.shiftwidth = 2
o.tabstop = 2
o.expandtab = true
o.softtabstop = 2
o.list = true
o.listchars = { tab = "→ ", space = "·" }
o.cursorline = true
vim.cmd([[autocmd FileType * set formatoptions-=ro]]) -- disable new line auto comment <3

local map_opts = { silent = true }
local map = vim.keymap.set
map("v", "<", "<gv", map_opts)
map("v", ">", ">gv", map_opts)
map({ "n", "v" }, "c", '"_c', map_opts)
map({ "n", "v" }, "C", '"_C', map_opts)
map("v", "p", "P", map_opts)
map({ "n", "v", "i" }, "<c-v>", ":vsplit<CR>", map_opts)
map({ "n", "v", "i" }, "<c-down>", ":NavigatorDown<CR>", map_opts)
map({ "n", "v", "i" }, "<c-up>", ":NavigatorUp<CR>", map_opts)
map({ "n", "v", "i" }, "<c-right>", ":NavigatorRight<CR>", map_opts)
map({ "n", "v", "i" }, "<c-left>", ":NavigatorLeft<CR>", map_opts)
map("n", "<leader>bo", ":%bd|e#|bd#<CR>", map_opts) -- close all buffers but the current one
map({ "n", "v", "i" }, "<C-x>", ":bd<CR>", map_opts)
map("n", "<leader>by", ":%y<CR>")
map("n", "<leader>bY", ":let @+ = expand('%:p')", map_opts)
map("n", "<Esc>", ":noh<CR>", map_opts)
map("n", "<Down>", "gj")
map("n", "<Up>", "gk")

local augroup = vim.api.nvim_create_augroup("mat.cfg", { clear = true })
local autocmd = vim.api.nvim_create_autocmd
autocmd("TextYankPost", {
  group = augroup,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/EdenEast/nightfox.nvim",
  "https://github.com/tpope/vim-eunuch",
  "https://github.com/tpope/vim-fugitive",
  "https://github.com/chentoast/marks.nvim",
  "https://github.com/numToStr/Navigator.nvim",
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/supermaven-inc/supermaven-nvim",
  "https://github.com/folke/flash.nvim",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/MeanderingProgrammer/render-markdown.nvim",
  "https://github.com/zk-org/zk-nvim",
})
local fzf = require("fzf-lua")
local function setup_lsp()
  map("n", "<leader>ld", vim.diagnostic.open_float, map_opts)
  vim.lsp.enable({ "bashls", "lua_ls", "ts_ls", "clang", "yamlls" })

  local chars = {}
  for i = 32, 126 do
    table.insert(chars, string.char(i))
  end
  local pumMap = function(insertKmap, pumKmap)
    map("i", insertKmap, function()
      if vim.fn.pumvisible() == 0 then
        return insertKmap
      else
        return pumKmap
      end
    end, { expr = true })
  end
  autocmd("LspAttach", {
    group = augroup,
    callback = function(args)
      local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
      if client:supports_method("textDocument/implementation") then
        local bufopts = { noremap = true, silent = true, buffer = args.buf }
        map("n", "gd", vim.lsp.buf.definition, bufopts)
        map("n", "gD", vim.lsp.buf.type_definition, bufopts)
        map("n", "K", vim.lsp.buf.hover, bufopts)
        map("n", "gr", fzf.lsp_references, bufopts)
        map("n", "<leader>lr", vim.lsp.buf.rename, bufopts)
        map("n", "<leader>o", fzf.lsp_document_symbols, bufopts)
        map({ "n", "i" }, "<S-Down>", vim.diagnostic.goto_next, bufopts)
        map({ "n", "i" }, "<S-Up>", vim.diagnostic.goto_prev, bufopts)
        pumMap("<Down>", "<C-n>")
        pumMap("<Up>", "<C-p>")
        pumMap("<CR>", "<C-y>")
      end
      if client:supports_method("textDocument/completion") then
        client.server_capabilities.completionProvider.triggerCharacters = chars
        vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
      end
    end,
  })
end
local function setup_fzf()
  map("n", "<leader>sf", fzf.files, map_opts)
  map("n", "<leader>sr", fzf.oldfiles, map_opts)
  map("n", "<leader>st", fzf.live_grep, map_opts)
  map("n", "<leader>sh", fzf.helptags, map_opts)
  map("n", "<leader>sd", fzf.lsp_document_diagnostics, map_opts)
  map("n", "<leader><leader>", fzf.buffers, { desc = "Fzf show buffers", noremap = true, silent = true })
  fzf.setup({ "max-perf", winopts = { height = 1, width = 1 } })
end
local function setup_oil()
  require("oil").setup({
    skip_confirm_for_simple_edits = true,
    watch_for_changes = true,
    view_options = { show_hidden = true },
  })
  map("n", "<leader>e", ":Oil<cr>")
end
local function setup_supermaven()
  require("supermaven-nvim").setup({
    keymaps = { accept_suggestion = "<S-Tab>" },
    color = { suggestion_color = "#005f5f", cterm = 23 },
  })
  map("n", "<leader>a", ":SupermavenToggle<CR>", map_opts)
end
local function setup_flash()
  require("flash").setup({ labels = "neioarst" })
  map({ "n", "x", "o" }, "s", function()
    require("flash").jump()
  end, { desc = "Flash" })
end
local function setup_conform()
  require("conform").setup({
    format_on_save = function(bufnr)
      local enable_autoformat = not vim.g.disable_autoformat and not vim.b[bufnr].disable_autoformat
      return enable_autoformat and { timeout_ms = 500, lsp_format = "fallback" } or nil
    end,
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "prettier", "eslint", stop_after_first = true },
      typescript = { "prettier", "eslint", stop_after_first = true },
      typescriptreact = { "prettier", "eslint", stop_after_first = true },
      javascriptreact = { "prettier", "eslint", stop_after_first = true },
      json = { "prettier", "eslint", stop_after_first = true },
      jsonc = { "prettier", "eslint", stop_after_first = true },
      yaml = { "prettier", "eslint", stop_after_first = true },
      html = { "prettier", "eslint", stop_after_first = true },
      rust = { "rustfmt", lsp_format = "fallback" },
    },
  })
  map("n", "<leader>f", function()
    vim.b.disable_autoformat = not vim.b.disable_autoformat
  end, map_opts)
end

vim.api.nvim_set_hl(0, "StatusLineGitClean", { fg = "#81b29a", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "StatusLineGitDirty", { fg = "#c94f6d", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "StatusLineFileChanged", { fg = "#f4a261", bg = "NONE", bold = true })

function RENDER_STATUSBAR()
  local autoformat = (vim.g.disable_autoformat == true or vim.b.disable_autoformat) and "-" or "F"
  local supermaven = pcall(require, "supermaven-nvim.api") and require("supermaven-nvim.api").is_running() and "AI"
    or "-"
  local cwd = vim.fn.getcwd() or ""
  local cwd_with_tilde = vim.fn.fnamemodify(cwd, ":~")
  local git_status = vim.fn.system("git status --porcelain 2>/dev/null"):gsub("\n", "")
  local branch_color = git_status == "" and "%#StatusLineGitClean#" or "%#StatusLineGitDirty#"
  local branch = branch_color
    .. vim.fn.system("git branch --show-current 2>/dev/null"):gsub("\n", "")
    .. "%#StatusLine#"
  local filename_color = vim.bo.modified and "%#StatusLineFileChanged#" or "%#StatusLine#"
  local filename = filename_color .. (vim.fn.expand("%:p")):sub(#cwd + 1) .. "%#StatusLine#"
  return string.format(
    "[*%s][%s%s]%%=[%s][%s][%s][%d,%d]",
    branch,
    cwd_with_tilde,
    filename,
    autoformat,
    supermaven,
    vim.bo.filetype,
    vim.fn.line("."),
    vim.fn.col(".")
  )
end
vim.o.statusline = "%{%v:lua.RENDER_STATUSBAR()%}"

require("nightfox").setup({})
vim.cmd([[colorscheme nightfox]])

setup_fzf()
setup_lsp()
setup_oil()
setup_supermaven()
setup_flash()
setup_conform()

require("Navigator").setup({})
require("zk").setup({})
require("marks").setup({ mappings = { delete_line = "M" } })
require("render-markdown").setup({})
