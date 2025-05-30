return function ()
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
      return ""
    end

    return "AF"
  end

  local function copilot_autosuggestion()
    if vim.b.copilot_suggestion_auto_trigger == true then
      return "CPLT"
    end

    return ""
  end

  -- lvim.builtin.lualine.sections.lualine_c = { current_project }
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
      lualine_c = { filename_plus_project, require("recorder").recordingStatus },
      -- lualine_c = { filename_plus_project },
      -- lualine_x = { "fileformat", "filetype" },
      lualine_x = { copilot_autosuggestion, autoformat, "g:coc_status" },
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
