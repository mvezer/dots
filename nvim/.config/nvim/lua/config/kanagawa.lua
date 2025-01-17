--- kanagawa.nvim (https://github.com/rebelot/kanagawa.nvim)
return function ()
  require("kanagawa").setup({
    theme = "dragon",
    transparent = true,
    colors = {
      theme = {
        all = {
          ui = { bg_gutter = "none" },
        },
      }
    }
  })
  vim.cmd.colorscheme("kanagawa")
end
