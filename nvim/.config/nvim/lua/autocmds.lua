-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})


vim.api.nvim_create_user_command("ZkNewWithTitle", function()
  require("zk.commands").get("ZkNew")({ title = vim.fn.input("Note title: ") })
end, {})
vim.api.nvim_create_user_command("ZkCdWork", function()
  vim.cmd("cd " .. (vim.env.ZK_WORK_DIR or "~/Dropbox/notes/work"))
end, {})

vim.api.nvim_create_user_command("ZkCdPersonal", function()
  vim.cmd("cd " .. (vim.env.ZK_PERSONAL_DIR or "~/Dropbox/notes/personal"))
end, {})
