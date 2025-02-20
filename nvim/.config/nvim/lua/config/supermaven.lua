return function ()
  require("supermaven-nvim").setup({
    -- keymaps = {
    -- }
    color = {
      -- suggestion_color = "#94E2D5", -- catppuccin's cyan
      suggestion_color = "#40d8e3", -- some cyan that's NOT catppuccin - on purpose
      cterm = 99, -- arbitrary number, the above color only shows up when cterm is set TO ANYTHING
    },
    condition = function()
      return vim.bo.filetype == "markdown"
    end
  })
end
