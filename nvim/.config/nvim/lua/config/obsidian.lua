return function()
  local notes_path =  "~/Dropbox/notes"
  require("obsidian").setup({
    workspaces = {
      {
        name = "all-the-things",
        path = notes_path,
      }
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
      vim.fn.jobstart({"open", url})  -- Mac OS
      -- vim.fn.jobstart({"xdg-open", url})  -- linux
      -- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
      -- vim.ui.open(url) -- need Neovim 0.10.0+
    end,
  })

  function FindObsidianNotesWithSnackPicker (args)
    local vault = vim.fn.expand(notes_path)
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
            ["<c-x>"] = { "create_note", desc = "Create new note", mode = { "i", "n" } },
          },
        },
      },
    })
  end
end
