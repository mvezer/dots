local plugin_spec = {
  { "chentoast/marks.nvim",    event = "VeryLazy", opts = {} },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = { labels = "neioarst" },
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    }
  },
  {
    "beauwilliams/statusline.lua",
    dependencies = {
      "nvim-lua/lsp-status.nvim",
    },
    opts = { match_colorscheme = true },
  },
  {
    "leath-dub/snipe.nvim",
    keys = {
      { "<leader><leader>", function() require("snipe").open_buffer_menu() end, desc = "Open Snipe buffer menu" }
    },
    opts = { hints = { dictionary = "neioarst" }, ui = { open_win_override = { border = "rounded" } } }
  },
  { "williamboman/mason.nvim", opts = {} },
  { "ibhagwan/fzf-lua",        opts = {} }
  -- { "ibhagwan/fzf-lua",        opts = {} }
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
  checker = { enabled = true },
})
