-- require("commands/notes")
require("commands/format")
require("commands/slack")

-- Close empty buffers
local function close_empty_buffers()
	local buffers = vim.api.nvim_list_bufs()
	for _, b in ipairs(buffers) do
		local name = vim.api.nvim_buf_get_name(b)
		if name == nil or name == "" then
			vim.api.nvim_buf_delete(b, { force = true })
		end
	end
end
vim.api.nvim_create_user_command("DeleteEmptyBuffers", close_empty_buffers, { nargs = "?" })

vim.api.nvim_create_user_command("Cdc", ":cd %:p:h", {})

-- fancy markdown
-- local markdown_conceal = vim.api.nvim_create_augroup("markdown_conceal", { clear = true })
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "markdown",
-- 	callback = function()
-- 		vim.opt_local.conceallevel = 1
-- 	end,
-- 	group = markdown_conceal,
-- })

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

local fuzzy_find_in_buffer = function()
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end
vim.api.nvim_create_user_command("FuzzyFind", fuzzy_find_in_buffer, { nargs = "?" })

-- local open_url_under_cursor = function()
-- 	if require("obsidian").util.cursor_on_markdown_link() then
-- 		vim.cmd("ObsidianFollowLink")
-- 	else
-- 		vim.cmd("URLOpenUnderCursor")
-- 	end
-- end
-- vim.api.nvim_create_user_command("OpenUrlUnderCursor", open_url_under_cursor, { nargs = "?" })

local vscode_show_tasks = function()
	require("telescope").extensions.vstask.tasks()
end
vim.api.nvim_create_user_command("VScodeShowTasks", vscode_show_tasks, { nargs = "?" })

local vscode_show_launch_configs = function()
	require("telescope").extensions.vstask.launch()
end
vim.api.nvim_create_user_command("VScodeShowLaunchConfigs", vscode_show_launch_configs, { nargs = "?" })
