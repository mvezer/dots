return {
  cmd = { "typescript-language-server", "--stdio" },
  root_dir = vim.fs.dirname(vim.fs.find({ "tsconfig.json", "package.json" }, { upward = true })[1]),
  filetypes = { "typescript", "typescriptreact" },
  format = function(_, args)
    if (vim.system({ 'which', 'prettier' }, { text = true }):wait()).code == 0 then
      vim.cmd("silent %!prettier --stdin-filepath " .. args.file)
    elseif (vim.system({ 'which', 'prettier-eslint' }, { text = true }):wait()).code == 0 then
      vim.cmd("silent %!prettier-eslint --stdin-filepath " .. args.file)
    elseif (vim.system({ 'which', 'eslint' }, { text = true }):wait()).code == 0 then
      vim.cmd("silent %!eslint --stdin-filepath " .. args.file .. " --fix")
    else
      vim.lsp.buf.format({ async = false, id = client.id })
    end
  end
}
