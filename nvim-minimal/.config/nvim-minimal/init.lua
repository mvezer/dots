local o         = vim.opt
local g         = vim.g
g.mapleader     = " "
o.clipboard     = "unnamed,unnamedplus"
o.cmdheight     = 1
o.number        = true
o.signcolumn    = "auto:4"
o.mouse         = "a"  -- enable mouse
o.breakindent   = true
o.undofile      = true -- persist undo
o.ignorecase    = true
o.hlsearch      = true
o.smartcase     = true
o.updatetime    = 250
o.timeoutlen    = 400
o.completeopt   = "menu,noinsert,popup,fuzzy"
o.termguicolors = true
o.hidden        = true
o.shiftwidth    = 2
o.tabstop       = 2
o.expandtab     = true
o.softtabstop   = 2
o.list          = true
o.listchars     = { tab = "→ ", space = "·" }
o.cursorline    = true
g.autoformat    = true
vim.cmd([[autocmd FileType * set formatoptions-=ro]]) -- disable new line auto comment <3

local opts = { silent = true }
local map = vim.keymap.set
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)
map({ "n", "v" }, "c", '"_c', opts)
map({ "n", "v" }, "C", '"_C', opts)
map("v", "p", "P", opts)
map({ "n", "v", "i" }, "<c-v>", ":vsplit<CR>", opts)
map({ "n", "v", "i" }, "<c-down>", ":NavigatorDown<CR>", opts)
map({ "n", "v", "i" }, "<c-up>", ":NavigatorUp<CR>", opts)
map({ "n", "v", "i" }, "<c-right>", ":NavigatorRight<CR>", opts)
map({ "n", "v", "i" }, "<c-left>", ":NavigatorLeft<CR>", opts)
map("n", "<leader>bo", ":%bd|e#|bd#<CR>", opts) -- close all buffers but the current one
map({ "n", "v", "i" }, "<C-x>", ":bd<CR>", opts)
map("n", "<leader>by", ":%y<CR>")
map("n", "<leader>bY", ":let @+ = expand('%:p')", opts)
map("n", "<Esc>", ":noh<CR>", opts)
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
  "https://github.com/nvim-treesitter/nvim-treesitter-context",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/EdenEast/nightfox.nvim",
  "https://github.com/tpope/vim-eunuch",
  "https://github.com/tpope/vim-fugitive",
  "https://github.com/chentoast/marks.nvim",
  "https://github.com/numToStr/Navigator.nvim",
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/supermaven-inc/supermaven-nvim",
  "https://github.com/folke/flash.nvim",
  "https://github.com/nvim-lualine/lualine.nvim"
})
local fzf = require("fzf-lua")
local function setup_lsp()
  map("n", "<leader>ld", vim.diagnostic.open_float, opts)
  vim.lsp.enable({ "bashls", "lua_ls", "ts_ls", "clang", "yamlls" })

  local chars = {} -- trigger autocompletion on EVERY keypress
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
      if client.config.format ~= nil then
        autocmd("BufWritePre", {
          group = augroup,
          callback = function() client.config.format(client, args) end
        })
      end
    end
  })
end
local function setup_fzf()
  map("n", "<leader>sf", fzf.files, { desc = "Fzf [s]earch [f]iles", noremap = true, silent = true })
  map("n", "<leader>sr", fzf.oldfiles, { desc = "Fzf [s]earch [r]ecent files", noremap = true, silent = true })
  map("n", "<leader>st", fzf.live_grep, { desc = "Fzf [s]earch [t]text", noremap = true, silent = true })
  map("n", "<leader>sh", fzf.helptags, { desc = "Fzf [h]elp tags", noremap = true, silent = true })
  map("n", "<leader>sd", fzf.lsp_document_diagnostics,
    { desc = "Fzf [s]earch [d]iagnostics", noremap = true, silent = true })
  map("n", "<leader><leader>", fzf.buffers, { desc = "Fzf show buffers", noremap = true, silent = true })
  fzf.setup({ "max-perf" })
end
local function setup_oil()
  require "oil".setup {
    skip_confirm_for_simple_edits = true,
    watch_for_changes = true,
    view_options = { show_hidden = true },
  }
  map("n", "<leader>e", ":Oil<cr>")
end
local function setup_supermaven()
  if require("supermaven-nvim.api").is_running() then return end
  require "supermaven-nvim".setup {
    keymaps = { accept_suggestion = "<S-Tab>" },
    color = { suggestion_color = "#005f5f", cterm = 23 },
  }
end
local function setup_flash()
  require "flash".setup { labels = "neioarst" }
  map({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash" })
end
local function setup_lualine()
  local function filename_plus_project()
    local dir = vim.fn.getcwd() or ""
    local full_path = vim.fn.expand("%:h"):sub(#(vim.fn.getcwd() or "") + 1)
    local project = "[" .. string.match(dir, ".+/(.+)$") .. "]"
    local relative_path = buffer_dir:gsub(dir, "")
    local modified_suffix = ""
    if vim.bo.modified then
      modified_suffix = "[+]"
    end
    return project .. " " .. relative_path .. " " .. modified_suffix
  end

  local function autoformat()
    if vim.g.disable_autoformat == true or vim.b.disable_autoformat == true then
      return "-"
    end

    return "[F]"
  end

  local function supermaven()
    if require("supermaven-nvim.api").is_running() then
      return "[AI]"
    else
      return "-"
    end
  end

  require("lualine").setup({
    options = {
      always_show_tabline = true,
      icons_enabled = true,
      theme = "auto",
      component_separators = "|",
      section_separators = "",
      globalstatus = true,
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diagnostics" },
      lualine_c = { function() return (vim.fn.expand("%:p")):sub(#(vim.fn.getcwd() or "") + 1) end },
      lualine_x = { autoformat, supermaven },
      lualine_y = { "filetype" },
      lualine_z = { "progress" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
  })
end

require "nightfox".setup {}
vim.cmd([[colorscheme nightfox]])

setup_fzf()
setup_lsp()
setup_oil()
setup_supermaven()
setup_flash()
setup_lualine()
require "Navigator".setup {}
require "marks".setup { mappings = { delete_line = "M" } }
