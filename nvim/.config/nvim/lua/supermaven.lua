return function()
  require("supermaven-nvim").setup({
    keymaps = { accept_suggestion = "<S-Tab>" },
    color = { suggestion_color = "#005f5f", cterm = 23 },
  })
end
