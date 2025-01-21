return function ()
  require("mini.files").setup({
    mappings = {
      go_in = "<Right>",
      go_in_plus = "<CR>",
      go_out = "<Left>",
      go_out_plus = "<BS>",
    },
    windows = {
      preview = true,
      width_preview = 100
    }
  })
end
