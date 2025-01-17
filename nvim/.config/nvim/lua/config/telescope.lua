return function()
  require("telescope").setup({
    defaults = {
      layout_config = {
        width = 0.95,
        height = 0.95,
      },
      mappings = {
        i = {
          ["<c-u>"] = false,
          ["<c-d>"] = require("telescope.actions").delete_buffer
        },
      },
      path_display = {
        shorten = 2,
      },
    },
    extensions = {
      theme = 'ivy',
      prefer_locations = true, -- always use telescope locations to preview definitions/declarations/implementations etc
      push_cursor_on_edit = true, -- save the cursor position to jump back in the future
      timeout = 3000, -- timeout for coc commands
    }
  })

  require("telescope").load_extension("fzf")
  require("telescope").load_extension("neoclip")
  require("telescope").load_extension("undo")
  -- require("telescope").load_extension("coc")
end
