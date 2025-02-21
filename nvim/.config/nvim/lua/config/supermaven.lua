-- https://github.com/supermaven-inc/supermaven-nvim
return function ()
  require("supermaven-nvim").setup({
    keymaps = {
      accept_suggestion = "<S-Tab>"
    },
    color = {
      -- suggestion_color = "#94E2D5", -- catppuccin's cyan
      -- suggestion_color = "#40d8e3", -- some cyan that's NOT catppuccin - on purpose
      suggestion_color = "#BAC2DE", -- catppuccin's white
      cterm = 99, -- arbitrary number, the above color only shows up when cterm is set TO ANYTHING
    },
    condition = function()
      return vim.bo.filetype == "markdown"
    end
  })
end
