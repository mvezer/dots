return function()
  vim.api.nvim_create_user_command("NeoTreeFloatCurrentDir", function()
    -- Get directory of current buffer
    local buffer_dir = vim.fn.expand("%:p:h")

    -- Open Neo-tree in float window at buffer's directory
    vim.cmd("Neotree float dir=" .. buffer_dir)
  end, {})
  require("neo-tree").setup({
    filesystem = {
      filtered_items = { hide_dotfiles = false, hide_gitignored = false },
      commands = { avante_add_files = require("ai").avante_add_files },
    },
    window = { mappings = { ["A"] = "avante_add_files" } },
  })
end
