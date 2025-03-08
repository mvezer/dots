local function get_workspaces()
  if vim.fn.has("mac") == 1 then
    return {
      {
        name = "work",
        path =   "~/Documents/Notes/",
      },
      {
        name = "personal",
        path =   "~/notes/",
      },
    }
    else
    return {
      {
        name = "personal",
        path =   "~/notes/",
      },
    }
  end
end

return function()
  local work_notes_path =  "~/Documents/Notes/"
  require("obsidian").setup({
    workspaces = get_workspaces(),
    daily_notes = {
      folder = "dailies",
      -- Optional, if you want to change the date format for the ID of daily notes.
      date_format = "%d.%m.%Y",
      -- Optional, if you want to change the date format of the default alias of daily notes.
      -- alias_format = "%B %-d, %Y",
      -- Optional, default tags to add to each new daily note created.
      default_tags = { "daily-notes" },
      -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      template = "daily"
    },
    templates = {
      folder = "templates",
      date_format = "%d.%m.%Y",
      time_format = "%H:%M",
      -- A map for custom variables, the key should be the variable and the value a function
      substitutions = {},
    },
    ui = {
      enable = false, -- we are using markview for fancy markdown, no obsidian ui
      checkboxes = {
        [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
        ["x"] = { char = "", hl_group = "ObsidianDone" },
      }
    },
    follow_url_func = function(url)
      -- Open the URL in the default web browser.
      if vim.fn.has("mac") == 1 then
        vim.fn.jobstart({"open", url})  -- Mac OS
      else
        vim.fn.jobstart({"xdg-open", url})  -- linux
      end
      -- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
      -- vim.ui.open(url) -- need Neovim 0.10.0+
    end,
  })

  function FindObsidianNotesWithSnackPicker (args)
    local vault = vim.fn.expand(work_notes_path)
    Snacks.picker.pick("grep", {
      cwd = vault,
      actions = {
        create_note = function(picker, item)
          picker:close()
          vim.cmd("ObsidianNew " .. picker.finder.filter.search)
        end,
      },
      win = {
        input = {
          keys = {
            ["<c-n>"] = { "create_note", desc = "Create new note", mode = { "i", "n" } },
          },
        },
      },
    })
  end
end
