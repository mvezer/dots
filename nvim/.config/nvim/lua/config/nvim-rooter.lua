return function ()
  require("nvim-rooter").setup({
    rooter_patterns = {
      "package.json",
      "init.lua",
      "go.mod",
      ".git",
    }
  })
end
