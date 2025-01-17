-- async git functions
local M = {}

M.is_working_tree_clean = function(path)
	path = path or "."
	local cmd = string.format("git -C '%s' status --porcelain", path)
	local output = vim.fn.systemlist(cmd)
	return #output == 0
end

M.commit_all = function(message, path)
	path = path or "."
	local cmd = string.format("git -C '%s' commit -am '%s'", path, message)
	return vim.fn.system(cmd)
end

M.push = function(path)
	path = path or "."
	local cmd = string.format("git -C '%s' push", path)
	return vim.fn.system(cmd)
end

M.commit_all_and_push = function(message, path)
	path = path or "."
	local cmd = string.format(
		"git -C '%s' add --all && git -C '%s' commit -am '%s' && git -C '%s' push",
		path,
		path,
		message,
		path
	)
	return vim.fn.system(cmd)
end

M.pull = function(path)
	path = path or "."
	local cmd = string.format("git -C '%s' pull", path)
	return vim.fn.system(cmd)
end

return M
