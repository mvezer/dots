return function()
  local os = vim.loop.os_uname().sysname
  vim.cmd([[do FileType]])
  if os == "Linux" then
    vim.cmd([[
       function OpenMarkdownPreview (url)
          let cmd = "firefox --new-window ". shellescape(a:url)
          silent call system(cmd)
       endfunction
       ]])
  else
    vim.cmd([[
       function OpenMarkdownPreview (url)
          let cmd = "open -n -a \"/Applications/Brave Browser.app\" --args --new-window ". shellescape(a:url)
          silent call system(cmd)
       endfunction
       ]])
  end
  -- make it OS-dependent - "open" does not work on linux
  vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
end
