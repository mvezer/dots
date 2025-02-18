return function()
  require("obsidian").setup({
    workspaces = {
      {
        name = "all-the-things",
        path = "~/Dropbox/notes"
      }
    },
    ui = {
      enable = false, -- we are using markview for fancy markdown, no obsidian ui
      checkboxes = {
        [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
        ["x"] = { char = "", hl_group = "ObsidianDone" },
      }
    }
  })
end
