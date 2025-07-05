return function()
  local bufferline = require("bufferline")
  bufferline.setup({
    options = {
      style_preset = bufferline.style_preset.no_italic,
      pick = { alphabet = "neioarst" },
      show_buffer_close_icons = false,
      always_show_bufferline = false,
    },
  })
end
