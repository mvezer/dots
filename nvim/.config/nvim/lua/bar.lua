return function()
  local function filename_plus_project()
    local dir = vim.fn.getcwd() or ""
    local buffer_dir = vim.fn.expand("%")
    local project = "[" .. string.match(dir, ".+/(.+)$") .. "]"
    local relative_path = buffer_dir:gsub(dir, "")
    local modified_suffix = ""
    if vim.bo.modified then
      modified_suffix = "[+]"
    end
    return project .. " " .. relative_path .. " " .. modified_suffix
  end

  local function autoformat()
    if vim.g.disable_autoformat == true or vim.b.disable_autoformat == true then
      return "--"
    end

    return "AF"
  end

  local function zk_mode()
    for _, v in pairs(require("zk-config").zk_modes) do
      if vim.fn.getcwd() == v.dir then
        return v.icon
      end
    end

    return ""
  end

  require("lualine").setup({
    options = {
      always_show_tabline = true,
      icons_enabled = true,
      theme = "auto",
      component_separators = "|",
      section_separators = "",
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = { filename_plus_project },
      lualine_x = { zk_mode, autoformat },
      lualine_y = { "filetype" },
      lualine_z = { "progress" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {},
  })
end
