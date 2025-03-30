return function()
	require("catppuccin").setup({
		flavour = "mocha",
		-- transparent_background = true,
		term_colors = true,
		custom_highlights = function()
			return {
				-- In case of using transparent background, Noice complains  if the NotifyBackground hl group is not set
				NotifyBackground = { bg = "#000000" },
			}
		end,
	})
	vim.cmd.colorscheme("catppuccin")
end
