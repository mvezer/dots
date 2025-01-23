return function ()
  require("neo-tree").setup({
    filesystem = {
      follow_current_file = {
        enabled = true,
        leave_dirs_open = true
      },
      filtered_items = {
        hide_dotfiles = false,
      },
      window = {
        position = "float"
      }
    }
  })
end
