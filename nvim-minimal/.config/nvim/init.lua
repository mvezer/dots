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

-- Plugins
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
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mfussenegger/nvim-dap",
  "https://github.com/igorlfs/nvim-dap-view",
})

-- Utils
local map_opts = { silent = true }
local map = vim.keymap.set
local augroup = vim.api.nvim_create_augroup("mat.cfg", { clear = true })
local autocmd = vim.api.nvim_create_autocmd
local fzf = require("fzf-lua")

-- Mappings
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
map("n", "<leader>by", ":%y<CR>", map_opts)
map("n", "<leader>bY", ":let @+ = expand('%:p')", map_opts)
map("n", "<Esc>", ":noh<CR>", map_opts)
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")
map("n", "<Down>", "gj", map_opts)
map("n", "<Up>", "gk", map_opts)

-- Highlight on yank
autocmd("TextYankPost", {
  group = augroup,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- LSP
local function setup_lsp()
  map("n", "<leader>ld", vim.diagnostic.open_float, map_opts)
  vim.lsp.enable("ts_ls")
  vim.lsp.config("ts_ls", {
    cmd = { "typescript-language-server", "--stdio" },
    root_dir = vim.fs.dirname(vim.fs.find({ "tsconfig.json", "package.json" }, { upward = true })[1]),
    filetypes = { "typescript", "typescriptreact" },
  })

  vim.lsp.enable("lua_ls")
  vim.lsp.config("lua_ls", {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = {
      ".luarc.json",
      ".luarc.jsonc",
      ".luacheckrc",
      ".stylua.toml",
      "stylua.toml",
      "selene.toml",
      "selene.yml",
      ".git",
    },
    settings = {
      Lua = {
        diagnostics = {
          globals = {
            "vim",
            "vim.loop",
            "vim.loop.os_uname",
            "vim.uv",
            "kong",
            "ngx",
            "awesome",
            "root",
            "client",
            "screen",
          },
        },
        workspace = {
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
            ["/usr/share/awesome/lib"] = true,
          },
        },
      },
    },
  })

  vim.lsp.enable("clangd")
  vim.lsp.config("clangd", {
    cmd = { "clangd", "--background-index" },
    init_options = {
      usePlaceholders = true,
      completeUnimported = true,
      clangdFileStatus = true,
    },
    root_dir = vim.fn.getcwd(),
    filetypes = { "c", "cpp" },
  })

  vim.lsp.enable("bashls")
  vim.lsp.config("bashls", {
    cmd = { "bash-language-server", "start" },
    filetypes = { "sh, zsh" },
    root_dir = vim.fn.getcwd(),
  })

  vim.lsp.enable("yamlls")
  vim.lsp.config("yamlls", {
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml" },
    root_dir = vim.fn.getcwd(),
  })

  vim.lsp.enable("jsonls")
  vim.lsp.config("jsonls", {
    cmd = { "vscode-json-language-server", "--stdio" },
    filetypes = { "json" },
    root_dir = vim.fn.getcwd(),
  })
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
        map("n", "gd", fzf.lsp_definitions, bufopts)
        map("n", "gD", fzf.lsp_typedefs, bufopts)
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

-- DAP
local function setup_dap()
  local dap = require("dap")
  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
      args = { "--port", "${port}" },
    },
  }
  dap.configurations.cpp = {
    {
      name = "Launch",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      args = {},
      runInTerminal = false,
    },
  }
  dap.configurations.c = dap.configurations.cpp
  map("n", "<leader>d", function()
    require("dap").continue()
  end, map_opts)
  map("n", "<leader>D", function()
    require("dap").disconnect()
  end, map_opts)
  map("n", "<leader>r", function()
    require("dap").repl.toggle()
  end, map_opts)
  map("n", "<leader>R", function()
    require("dap").run()
  end, map_opts)
  map("n", "<leader>w", function()
    require("dap").repl.toggle()
  end, map_opts)
  require("dap-view").setup({})
end

-- FZF-lua
local function setup_fzf()
  map("n", "<leader>sf", fzf.files, map_opts)
  map("n", "<leader>sr", fzf.oldfiles, map_opts)
  map("n", "<leader>st", fzf.live_grep, map_opts)
  map("n", "<leader>sh", fzf.helptags, map_opts)
  map("n", "<leader>sd", fzf.lsp_document_diagnostics, map_opts)
  map("n", "<leader><leader>", fzf.buffers, map_opts)
  fzf.setup({ "max-perf", winopts = { height = 1, width = 1 } })
end

-- Oil
local function setup_oil()
  require("oil").setup({
    skip_confirm_for_simple_edits = true,
    watch_for_changes = true,
    view_options = { show_hidden = true },
  })
  map("n", "<leader>e", ":Oil<cr>")
end

-- Supermaven
local function setup_supermaven()
  require("supermaven-nvim").setup({
    keymaps = { accept_suggestion = "<S-Tab>" },
    color = { suggestion_color = "#005f5f", cterm = 23 },
  })
  map("n", "<leader>a", ":SupermavenToggle<CR>:redrawstatus<CR>", map_opts)
end

-- Flash
local function setup_flash()
  require("flash").setup({ labels = "neioarst" })
  map({ "n", "x", "o" }, "s", function()
    require("flash").jump()
    vim.api.nvim_feedkeys("zz", "n", false)
  end, { desc = "Flash" })
end

-- Conform
local function setup_conform()
  local formatters_by_ft = {
    lua = { "stylua" },
    rust = { "rustfmt", lsp_format = "fallback" },
  }
  for _, ft in ipairs({ "javascript ", "typescript", "typescriptreact", "javascriptreact ", "json", "jsonc ", "yaml ", "html" }) do
    formatters_by_ft[ft] = { "prettier", "eslint_d", stop_after_first = true }
  end
  require("conform").setup({
    format_on_save = function(bufnr)
      local enable_autoformat = not vim.g.disable_autoformat and not vim.b[bufnr].disable_autoformat
      return enable_autoformat and { timeout_ms = 500, lsp_format = "fallback" } or nil
    end,
    formatters_by_ft = formatters_by_ft,
  })
  map("n", "<leader>f", function()
    vim.b.disable_autoformat = not vim.b.disable_autoformat
    vim.cmd("redrawstatus")
  end, map_opts)
end

-- Statusbar
local function setup_statusbar()
  vim.api.nvim_set_hl(0, "StatusLineGitClean", { fg = "#81b29a", bg = "NONE", bold = true })
  vim.api.nvim_set_hl(0, "StatusLineGitDirty", { fg = "#c94f6d", bg = "NONE", bold = true })
  vim.api.nvim_set_hl(0, "StatusLineFileChanged", { fg = "#f4a261", bg = "NONE", bold = true })
  function RENDER_STATUSBAR()
    local autoformat = (vim.g.disable_autoformat == true or vim.b.disable_autoformat) and "-" or "F"
    local supermaven = pcall(require, "supermaven-nvim.api") and require("supermaven-nvim.api").is_running() and "AI" or "-"
    local cwd = vim.fn.getcwd() or ""
    local cwd_with_tilde = vim.fn.fnamemodify(cwd, ":~")
    local branch = vim.fn.system("git branch --show-current 2>/dev/null"):gsub("\n", "")
    if branch ~= "" and branch ~= nil then
      local git_status = vim.fn.system("git status --porcelain 2>/dev/null"):gsub("\n", "")
      local branch_color = git_status == "" and "%#StatusLineGitClean#" or "%#StatusLineGitDirty#"
      branch = " on  " .. branch_color .. branch .. "%#StatusLine#"
    end
    local filename = vim.fn.expand("%:p")
    if filename ~= "" and filename ~= nil then
      local filename_color = vim.bo.modified and "%#StatusLineFileChanged#" or "%#StatusLine#"
      filename = " [" .. filename_color .. (filename):sub(#cwd + 1) .. "%#StatusLine#" .. "]"
    end
    return string.format("%s%s%s%%=%s | %s | %s | %d,%d", cwd_with_tilde, branch, filename, autoformat, supermaven, vim.bo.filetype, vim.fn.line("."), vim.fn.col("."))
  end

  vim.o.statusline = "%{%v:lua.RENDER_STATUSBAR()%}"
end

require("Navigator").setup({})
require("zk").setup({})
require("marks").setup({ mappings = { delete_line = "M" } })
require("render-markdown").setup({})
require("nightfox").setup({})
require("mason").setup({})
vim.cmd([[colorscheme nightfox]])

setup_fzf()
setup_lsp()
setup_oil()
setup_supermaven()
setup_flash()
setup_conform()
setup_statusbar()
setup_dap()
