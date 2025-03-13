return function ()
  -- vim.api.nvim_exec([[
  -- function OpenMarkdownPreview (url)
  --   execute "silent ! open -a 'Zen Browser' -n --args --new-window " . a:url
  -- endfunction
  -- ]], false)
  vim.cmd([[do FileType]])
  vim.cmd([[
  function OpenMarkdownPreview (url)
    let cmd = "open -a 'Google Chrome' -n --args --new-window " . shellescape(a:url)
    silent call system(cmd)
    endfunction
    ]])
  vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
  vim.g.mkdp_filetypes = { "markdown" }
  vim.g.mkdp_auto_close = 0
  vim.g.mkdp_theme = "light"
end
