local plugin_spec = {
  { "williamboman/mason.nvim",          opts = {} },
  { "folke/lazydev.nvim",               opts = {} },
  { "saghen/blink.cmp",                 version = "1.*", config = require("blink") },
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
  { "tpope/vim-eunuch" },
  { "j-hui/fidget.nvim", opts = {} },
  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    config = function()
      require("nightfox").setup({ options = { transparent = true } })
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
    keys = { { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" } },
  },
  {
    "stevearc/conform.nvim",
    lazy = false,
    config = require("format"),
  },
  { "nvim-lualine/lualine.nvim",      lazy = true,                   event = "BufRead", config = require("bar") },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = "typescript", "javascript", "lua", "dockerfile", "yaml", "json", "bash", "c", "cpp", "toml", "go" },
  },
  { "ibhagwan/fzf-lua",               opts = require("fzf") },
  { "supermaven-inc/supermaven-nvim", config = require("supermaven") },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = { file_types = { "markdown", "Avante" } },
    ft = { "markdown", "Avante" },
  },
  { "kdheepak/lazygit.nvim", config = function() vim.g.lazygit_floating_window_scaling_factor = 1.0 end },
  { "towolf/vim-helm",       ft = "helm" },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function() vim.g.mkdp_filetypes = { "markdown" } end,
    config = require("markdown"),
    ft = { "markdown" },
  },
  { "numToStr/Navigator.nvim", opts = {} },
  { "Wansmer/treesj",          lazy = true,                    event = "BufReadPost",                            opts = { use_default_keymaps = false } },
  { "zk-org/zk-nvim",          config = require("zk-config") },
  { "b0o/schemastore.nvim" },
  { "stevearc/oil.nvim",       config = require("oil-config"), dependencies = { "nvim-tree/nvim-web-devicons" }, lazy = false },
  { "benomahony/oil-git.nvim" },
  {
    "yetone/avante.nvim",
    build = "make",
    event = "VeryLazy",
    version = false,
    opts = require("avante-config"),
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "echasnovski/mini.pick",         -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "stevearc/dressing.nvim",        -- for input provider dressing
      "folke/snacks.nvim",             -- for input provider snacks
      "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
      -- "zbirenbaum/copilot.lua",        -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
    },
  }
}

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
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
