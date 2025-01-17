return function ()
  vim.g.snacks_animate = false
  require("snacks").setup({
    bigfile = { enabled = true },
    bufdelete = { enabled = true },
    dashboard = { enabled = false },
    debug = { enabled = true },
    dim = { enabled = false },
    git = { enabled = true },
    indent = {
      enabled = true,
      animate = {
        enabled = false
      }
    },
    input = { enabled = true },
    lazygit = { enabled = true },
    notifier = {
      enabled = true,
      level = vim.log.levels.TRACE,
      timeout = 3000
    },
    notify = { enabled = true },
    quickfile = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    -- toggle = {
    --   enabled = true,
    --   map = vim.keymap.set, -- keymap.set function to use
    --   which_key = true, -- integrate with which-key to show enabled/disabled icons and colors
    --   notify = true,
    -- },
    words = { enabled = false },
    zen = { enabled = true }
  })
end
