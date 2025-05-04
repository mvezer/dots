---------------------------------------
--- Markdown and notes-related stuff ---
---------------------------------------
-- local git_utils = require("commands/git-utils")
local os_name = vim.loop.os_uname().sysname
--
-- -- Save notes command
-- vim.api.nvim_create_user_command("SaveNotes", function()
-- 	if not git_utils.is_working_tree_clean() then
-- 		git_utils.commit_all_and_push("Update notes", NOTES_DIR)
-- 	end
-- end, { nargs = "?" })
--
-- -- Load notes command
-- vim.api.nvim_create_user_command("LoadNotes", function()
-- 	git_utils.pull(NOTES_DIR)
-- end, { nargs = "?" })
--
-- local function open_last_edited_note()
--   local oldfiles_result = vim.api.nvim_exec2("oldfiles", { output = true })
--   local oldfiles_tbl = vim.split(oldfiles_result.output, "\n")
--   local most_recent_note = NOTES_DIR .. "/README.md"
--   for _, file_path in pairs(oldfiles_tbl) do
--     local p = file_path:gsub("^%d+:%s", "")
--     if string.find(p, NOTES_DIR) then
--       most_recent_note = p
--       break
--     end
--   end
--   vim.cmd("e" .. most_recent_note)
-- end
-- vim.api.nvim_create_user_command("OpenLastEditedNote", open_last_edited_note, { nargs = "?" })
--
-- -- Pulls the notes at neovim startup
-- vim.api.nvim_create_augroup("AutoPullNotes", { clear = true })
-- vim.api.nvim_create_autocmd("VimEnter", {
-- 	group = "AutoPullNotes",
-- 	pattern = "*",
-- 	callback = function()
-- 		if vim.uv.cwd() == NOTES_DIR then
-- 			print("Pulling notes...")
-- 			vim.cmd("LoadNotes")
-- 		end
-- 	end,
-- })
--
-- local function hasFrontmatter()
-- 	local lines = vim.api.nvim_buf_get_lines(0, 0, 7, false)
-- 	if #lines >= 6 and lines[6]:match("^%-%-%-$") then
-- 		return true
-- 	end
-- 	return false
-- end
--
-- local function titleFromFilename()
-- 	local file_path = vim.fn.expand("%:p")
-- 	local filename = vim.fs.basename(file_path)
-- 	local guessed_title = filename:match("(.+)%..+$") or filename
-- 	return guessed_title
-- end
--
-- local function titleFromHeading()
-- 	local lines = vim.api.nvim_buf_get_lines(0, 0, 10, false)
-- 	local title = nil
-- 	local i = 1
-- 	while i < (#lines + 1) and title == nil do
-- 		if lines[i]:match("^# ") then
-- 			title = lines[i]:match("^# (.+)$")
-- 		end
-- 		i = i + 1
-- 	end
--
-- 	return title
-- end
--
-- local function updateModified()
-- 	local current_date = os.date("%Y-%m-%d %H:%M:%S %z")
-- 	vim.api.nvim_buf_set_lines(0, 3, 4, false, { "modified: " .. current_date })
-- end
--
-- local function isInNotesDir()
-- 	local file_path = vim.fn.expand("%:p")
-- 	return string.find(file_path, NOTES_DIR)
-- end
--
-- -- Adds the frontmatter to the current buffer
-- local function addFrontmatter()
-- 	local current_date = os.date("%Y-%m-%d %H:%M:%S %z")
-- 	local buf = vim.api.nvim_get_current_buf()
-- 	vim.api.nvim_buf_set_lines(buf, 0, 0, false, {
--     "---",
-- 		"title: " .. (titleFromHeading() or titleFromFilename()),
-- 		"created: " .. current_date,
-- 		"modified: " .. current_date,
-- 		"tags: []",
-- 		"---",
-- 		"",
-- 	})
-- end
--
-- -- Add frontmatter to the top of the buffer
-- vim.api.nvim_create_user_command("AddFrontmatter", addFrontmatter, { nargs = "?" })
--
-- -- Add frontmatter when a new buffer is created in the notes dir
-- vim.api.nvim_create_augroup("SaveNote", { clear = true })
-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	group = "SaveNote",
-- 	pattern = "*.md",
-- 	callback = function()
-- 		if isInNotesDir() then
-- 			if hasFrontmatter() then
-- 				updateModified()
-- 			else
-- 				addFrontmatter()
-- 			end
-- 		end
-- 	end,
-- })

-- Extract the URL from a markdown link returns nil if no markdown link found
local function extract_markdown_link(str)
    local link_pattern = "%[.-%]%((.-)%)"
    local url = string.match(str, link_pattern)
    return url or nil
end

-- Check if a link is remote or local
local function is_remote_link(link)
  if string.match(link, "^https?://") then
    return true
  end
  return false
end

-- Check if the URL is relative or absolute
local function is_absolute_url(url)
  if string.match(url, "^/") or string.match(url, "^~") then
    return true
  end
  return false
end

-- Open markdown remote or local link or just pass to the OpenUrlUnderCursor command as a fallback
local function open_markdown_link()
  local current_line = vim.api.nvim_get_current_line()
  local link = extract_markdown_link(current_line)
  if link == nil then
    vim.cmd("OpenUrlUnderCursor")
  elseif is_remote_link(link) then
    if os_name == "Darwin" then
      vim.fn.jobstart("open " .. link)
    else
      vim.fn.jobstart("xdg-open " .. link)
    end
  else
    if not is_absolute_url(link) then
      link = vim.fn.expand("%:p:h") .. "/" .. link
    end
    vim.cmd("edit " .. link)
  end
end
vim.api.nvim_create_user_command("OpenMarkdownLink", open_markdown_link, { nargs = "?" })

local function toggle_todo_item(text)
  local before, todo, after = string.match(text, "^(.*)(%- %[.%])(.*)$")
  if todo == nil then
    return text
  end
  if string.match(todo, "x") then
    return string.format("%s- [ ]%s", before, after)
  end

  return string.format("%s- [x]%s", before, after)
end

local function toggle_markdown_todo()
  local current_line = vim.api.nvim_get_current_line()
  vim.api.nvim_set_current_line(toggle_todo_item(current_line))
end
vim.api.nvim_create_user_command("ToggleMarkdownTodo", toggle_markdown_todo, { nargs = "?" })

local function obsidian_new_with_filename ()
  local note_name = vim.fn.input("Note title: ", "", "file")
  if note_name ~= nil then
    if string.sub(note_name, -3) ~= ".md" then
      note_name = note_name .. ".md"
    end
    vim.cmd(string.format("ObsidianNew %s", note_name))
  end
end
vim.api.nvim_create_user_command("ObsidianNewWithFileName", obsidian_new_with_filename, { nargs = "?" })
