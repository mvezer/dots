return function()
  require("obsidian").setup({
    workspaces = {
      {
        name = "all-the-things",
        path = "~/obsidiian-notes/all-the-things"
      }
    }
  })
end
