local plugin_spec = {
  { "williamboman/mason.nvim", opts = {} },
  { "folke/lazydev.nvim", opts = {} },
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason-lspconfig.nvim" },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "prismals", "eslint", "dockerls", "docker_compose_language_service" },
      })
    end,
  },
  { "j-hui/fidget.nvim", opts = {} },
  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme nightfox]])
    end,
  },
  { "chentoast/marks.nvim", event = "VeryLazy", opts = { mappings = { delete_line = "M" } } },
  { "nvim-lua/plenary.nvim" },
  { "MunifTanjim/nui.nvim" },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = { labels = "neioarst" },
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = require("format"),
  },
  {
    "nvim-lualine/lualine.nvim",
    lazy = true,
    event = "BufRead",
    config = require("bar"),
  },
  -- { "j-morano/buffer_manager.nvim", opts = { line_keys = "neioarst" } },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = "typescript",
      "javascript",
      "lua",
      "dockerfile",
      "yaml",
      "json",
      "bash",
      "c",
      "cpp",
      "toml",
      "go",
    },
  },
  { "ibhagwan/fzf-lua", opts = require("fzf") },
  { "supermaven-inc/supermaven-nvim", opts = { keymaps = { accept_suggestion = "<S-Tab>" } } },
  {
    -- Make sure to set this up properly if you have lazy=true
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      file_types = { "markdown", "Avante" },
    },
    ft = { "markdown", "Avante" },
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    build = "make",
    config = require("ai").setup_avante,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    lazy = false,
    config = require("neo-tree-config"),
  },
  { "kdheepak/lazygit.nvim" },
  { "brianhuster/live-preview.nvim" },
  { "towolf/vim-helm", ft = "helm" },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    config = function()
      local os = vim.loop.os_uname().sysname
      vim.cmd([[do FileType]])
      if os == "Linux" then
        vim.cmd([[
         function OpenMarkdownPreview (url)
            let cmd = "flatpak run \"com.brave.Browser\""
            silent call system(cmd)
         endfunction
         ]])
      else
        vim.cmd([[
         function OpenMarkdownPreview (url)
            let cmd = "open -n -a \"/Applications/Brave Browser.app\" --args --new-window ". shellescape(a:url)
            silent call system(cmd)
         endfunction
         ]])
      end
      -- make it OS-dependent - "open" does not work on linux
      vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
    end,
    ft = { "markdown" },
  },
  { "numToStr/Navigator.nvim", opts = {} },
  { "Wansmer/treesj", lazy = true, event = "BufReadPost", opts = { use_default_keymaps = false } },
  { "zk-org/zk-nvim", config = require("zk-config").zk_config },
  { "b0o/schemastore.nvim" },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    event = "BufRead",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      local bufferline = require("bufferline")
      bufferline.setup({
        options = {
          style_preset = bufferline.style_preset.no_italic,
          pick = { alphabet = "neioarst" },
          show_buffer_close_icons = false,
          always_show_bufferline = false,
        },
      })
    end,
    keys = {
      {
        "<leader><leader>",
        mode = { "n" },
        "<CMD>BufferLinePick<CR>",
        desc = "Pick buffer",
      },
    },
  },
}

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  spec = plugin_spec,
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  -- checker = { enabled = true },
})
