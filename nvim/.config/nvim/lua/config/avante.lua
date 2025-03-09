return function ()
  require("avante").setup({
    provider = "claude",
    file_selector = {
      provider = "snacks",
      provider_opts = {}
    }
  })
end
