return function ()
  vim.api.nvim_exec([[
  function OpenMarkdownPreview (url)
    execute "silent ! open -a 'Zen Browser' -n --args --new-window " . a:url
  endfunction
  ]], false)
  vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
  vim.g.mkdp_filetypes = { "markdown" }
  vim.g.mkdp_auto_close = 0
  vim.g.mkdp_theme = "light"
end
