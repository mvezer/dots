local M = {}

M.zk_modes = {
  work = { dir = vim.env.HOME .. "/Dropbox/notes/work", icon = "󰦑", is_default = vim.env.HOSTNAME == "rocinante" },
  personal = { dir = vim.env.HOME .. "/Dropbox/notes/personal", icon = "󰋜", is_default = vim.env.HOSTNAME ~= "rocinante" },
}

M.current_mode = function()
  for mode, v in pairs(require("zk-config").zk_modes) do
    if vim.fn.getcwd() == v.dir then
      return mode
    end
  end

  return nil
end

M.current_mode_icon = function()
  local mode = M.current_mode()
  if mode == nil then
    return ""
  end
  return M.zk_modes[mode].icon
end

M.create_note_commands = function()
  vim.api.nvim_create_user_command("ZkNewWithTitle", function()
    local title = vim.fn.input("Note title: ")
    if not title then
      return
    end
    require("zk.commands").get("ZkNew")({ title = title })
  end, {})
  vim.api.nvim_create_user_command("Z", function(opts)
    local mode = opts.args
    local dir = M.zk_modes.work.dir
    if mode then
      dir = M.zk_modes[mode].dir
    else
    end
    vim.cmd("cd " .. dir)
  end, {
    nargs = 1,
    desc = "Change ZK mode",
  })
  vim.api.nvim_create_user_command("ZkSetDefaultMode", M.set_default_mode, {})
  vim.api.nvim_create_user_command("ZkSetDefaultModeOrCurrent", function()
    if M.is_note_dir() then
      return
    end
    M.set_default_mode()
  end, {})
end

M.default_mode = function()
  for mode, v in pairs(M.zk_modes) do
    if v.is_default then
      return mode
    end
  end
  return nil
end

M.is_note_dir = function()
  local dir = vim.fn.getcwd()
  for _, v in pairs(M.zk_modes) do
    if dir == v.dir then
      return true
    end
  end
  return false
end

M.set_default_mode = function()
  local mode = M.default_mode()
  if mode == nil then
    mode = "work"
  end
  vim.cmd("cd " .. M.zk_modes[mode].dir)
end

M.zk_config = function()
  M.create_note_commands()
  require("zk").setup({
    picker = "fzf_lua",
    lsp = {
      -- `config` is passed to `vim.lsp.start(config)`
      config = {
        cmd = { "zk", "lsp" },
        name = "zk",
        -- on_attach = ...
        -- etc, see `:h vim.lsp.start()`
      },

      -- automatically attach buffers in a zk notebook that match the given filetypes
      auto_attach = {
        enabled = true,
        filetypes = { "markdown" },
      },
    },
  })
end

return M
