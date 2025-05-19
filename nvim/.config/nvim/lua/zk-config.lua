local M = {}

M.zk_modes = {
  work = { dir = vim.env.HOME .. "/Dropbox/notes/work", icon = "󰦑" },
  personal = { dir = vim.env.HOME .. "/Dropbox/notes/personal", icon = "󰋜" },
}

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
