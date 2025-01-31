return function()
  require("obsidian").setup({
    workspaces = {
      {
        name = "all-the-things",
        path = "~/notes"
      }
    }
  })
end
