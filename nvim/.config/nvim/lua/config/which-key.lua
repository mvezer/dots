return function ()
  require("which-key").setup({
    preset = "modern",
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = false
      },
      presets = {
        operators = false,
        motions = false,
        text_objects = false,
        windows = false,
        nav = false,
        z = false,
        g = false,
      },
    }
  })
end
