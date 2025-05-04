vim.g.neovide_floating_shadow = true
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_remember_window_size = true
vim.g.neovide_confirm_quit = false
vim.g.neovide_fullscreen = false
vim.g.neovide_input_macos_option_key_is_meta = "both"
if vim.loop.os_uname().sysname == "Linux" then
	vim.g.neovide_scale_factor = 0.7
else
	vim.g.neovide_scale_factor = 1.0
end
vim.opt.linespace = 1
vim.g.neovide_refresh_rate_idle = 5

-- no animations
vim.g.neovide_position_animation_length = 0
vim.g.neovide_cursor_animation_length = 0.00
vim.g.neovide_cursor_trail_size = 0
vim.g.neovide_cursor_animate_in_insert_mode = false
vim.g.neovide_cursor_animate_command_line = false
vim.g.neovide_scroll_animation_far_lines = 0
vim.g.neovide_scroll_animation_length = 0.00

local change_scale_factor = function(delta)
	vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end
vim.keymap.set("n", "<D-=>", function()
	change_scale_factor(1.25)
end)
vim.keymap.set("n", "<D-->", function()
	change_scale_factor(1 / 1.25)
end)
