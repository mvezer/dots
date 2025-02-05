local function cmd(command)
	return ":" .. command .. "<CR>"
end

local wk = require("which-key")
local Snacks = require("snacks")
local wk_config = {
	{ "<leader>/", function () Snacks.picker.lines() end, desc = "Fuzzily search in current buffer" },
	-- { "<leader>e", cmd("Neotree toggle"), desc = "Toggles the file explorer window" },
	{ "<leader>e", function ()
    Snacks.picker.explorer({
      finder = "explorer",
      layout = {
        layout = { position = "left" },
        preview = true
      }
    })
  end, desc = "Toggles the file explorer window" },
	{ "<leader>C", cmd("e $HOME/.config/nvim/lua"), desc = "Edit config" },
	{ "<leader>f", group = "Format" },
	{ "<leader>fF", cmd("Format"), desc = "Format with conform" },
	{ "<leader>ff", cmd("FormatToggle"), desc = "Toggle autoformatting" },
	{ "<leader>m", cmd("TSJToggle"), desc = "Toggle split/join" },

	--------------------------------------------- buffers ---------------------------------------------------
	{ "<leader>b", group = "Buffer" },
	{
		"<leader>ba",
		function()
			Snacks.bufdelete.all()
		end,
		desc = "Close [a]ll buffers",
	},
	{
		"<leader>bo",
		function()
			Snacks.bufdelete.other()
		end,
		desc = "Close [o]ther buffers",
	},
	{ "<leader>by", cmd("%y"), desc = "[Y]ank the entire buffer" },
	{ "<leader>bY", cmd("let @+ = expand('%:p')"), desc = "[Y]ank the full filepath" },
	{ "<leader>bd", cmd("Cdc"), desc = "Cd the current buffers dir" },
  { "<leader>bb", cmd("Neotree buffers toggle"), desc = "Show all open buffers" },
	{
		"<c-x>",
		function()
			Snacks.bufdelete()
		end,
		desc = "Close buffer",
		mode = { "n", "v", "i" },
	},
	{
		"<leader><leader>",
		function()
			require("snipe").open_buffer_menu()
		end,
		desc = "Pick buffer",
	},
	{ "<Tab>", cmd("bnext"), desc = "Next buffer" },
	{ "<S-Tab>", cmd("bprevious"), desc = "Previous buffer" },

	--------------------------------------------- search stuff ---------------------------------------------
	{ "<leader>s", group = "Search" },
	{ "<leader>sg", function() Snacks.picker.git_files() end, desc = "Search [g]it files" },
	{ "<leader>sh", function () Snacks.picker.help() end, desc = "Search [h]elp tags" },
	{ "<leader>sb", function () Snacks.picker.buffers() end, desc = "Search [b]buffers" },
	{ "<leader>sr", function () Snacks.picker.recent() end, desc = "Search [r]ecent files" },
	{ "<leader>sf", function () Snacks.picker.files() end, desc = "Search [f]iles" },
	{ "<leader>sw", function () Snacks.picker.grep_word() end, desc = "Search [w]ord", mode = { "n", "x" } },
	{ "<leader>st", function () Snacks.picker.grep() end, desc = "Search [t]ext" },
	{ "<leader>sj", function () Snacks.picker.jumps() end, desc = "Search [j]umps" },
	{ "<leader>su", function () Snacks.picker.undo() end, desc = "Search [u]ndo" },
	{ "<leader>sm", function () Snacks.picker.marks() end, desc = "Search [m]arks" },
	{ "<leader>sM", function () Snacks.picker.man() end, desc = "Search ma[n] pages" },
	{ "<leader>:", function () Snacks.picker.command_history() end, desc = "Command history" },
	-- { "<leader>sg", cmd("Telescope git_files"), desc = "Search [g]it files" },
	-- { "<leader>sf", cmd("Telescope find_files"), desc = "Search [f]iles" },
	-- { "<leader>sh", cmd("Telescope help_tags"), desc = "Search [h]elp tags" },
	-- {
	-- 	"<leader>sw",
	-- 	function()
	-- 		require("telescope.builtin").grep_string({ cwd = vim.fn.getcwd() })
	-- 	end,
	-- 	desc = "Search [w]ord under the cursor",
	-- },
	-- { "<leader>st", cmd("Telescope live_grep"), desc = "Search [t]ext" },
	-- { "<leader>sd", cmd("Telescope diagnostics"), desc = "Search [d]iagnostics" },
	-- { "<leader>sy", cmd("Telescope neoclip"), desc = "Search [y]anks (neoclip)" },
	-- { "<leader>sr", cmd("Telescope oldfiles"), desc = "Search [r]ecently opened files" },
	-- { "<leader>sR", cmd("Telescope registers"), desc = "Search [R]egisters" },
	-- { "<leader>sn", cmd("ObsidianSearch"), desc = "Search Obsidian [n]otes" }, -- NO shit
	-- { "<leader>su", cmd("Telescope undo"), desc = "Search undo list" },
	-- { "<leader>sb", cmd("Telescope buffers"), desc = "Search [b]uffers" },
	-- { "<leader>ss", cmd("Telescope git_files"), desc = "Search files in git repo" },
	-- { "<leader>sm", cmd("Telescope marks"), desc = "Search marks" },

	--------------------------------------------- git ---------------------------------------------
	{ "<leader>g", group = "Git" },
	{
		"<leader>gg",
		function()
			Snacks.lazygit()
		end,
		desc = "Opens Lazy[G]it",
	},
	{
		"<leader>gh",
		function()
			Snacks.lazygit.log_file()
		end,
		desc = "Opens git history of the current file",
	},
	-- { "<leader>gb", cmd("BlamerToggle"), desc = "Toggle blame" },
	{
		"<leader>gb",
		function()
			Snacks.git.blame_line()
		end,
		desc = "Show blame for current line",
	},

	--------------------------------------------- notes ---------------------------------------------
	{ "<leader>n", group = "Notes" },
	{ "<leader>ns", cmd("ObsidianSearch"), desc = "Searches notes" },
	{ "<leader>nn", cmd("ObsidianNewWithFileName"), desc = "Creates a new note" },

	--------------------------------------  AI stuff: Copilot & ChatGPT -------------------------------------
	{ "<leader>a", group = "AI functionality" },
	{
		"<leader>as",
		function()
			require("copilot.suggestion").toggle_auto_trigger()
		end,
		desc = "Get next copilot suggestion",
	},
	{ "<leader>ad", cmd("GpChatDelete"), desc = "Delete chat" },
	{ "<leader>an", cmd("GpChatNew"), desc = "New chat" },
	{ "<A-g>", cmd("GpChatToggle"), desc = "Toggle ChatGPT", mode = { "n", "v", "i" } },
	{ "<A-w>", cmd("GpWhisper"), desc = "Activate Whisper" },

	-- Test
	-- { "<leader>t", group = "Test" },
	-- { "<leader>tt", require("neotest").run.run, desc = "Run [t]est under the cursor" },
	-- {
	-- 	"<leader>tf",
	-- 	function()
	-- 		require("neotest").run.run(vim.fn.expand("%"))
	-- 	end,
	-- 	desc = "Run all tests in the current [f]ile",
	-- },

	-- Execute
	{ "<leader>x", group = "Execute" },
	{ "<leader>xx", cmd(".w !zsh -e"), desc = "Execute current line and output to command line" },
	{ "<leader>xX", cmd("%w !zsh -e"), desc = "Execute all lines and output to command line" },
	{
		"<leader>xl",
		cmd(".!zsh -e %"),
		desc = "Execute current line and replace it with the result",
		mode = { "n" },
		{ noremap = true, silent = false },
	},
	{ "<leader>xL", cmd("% !zsh -e %"), desc = "Execute all lines and replace them with the result" },

	--------------------------------------------- go ---------------------------------------------
	{ "g", group = "Go to" },
	{ "gx", cmd("OpenMarkdownLink"), desc = "Go to markdown link or open url under cursor", noremap = true },
	{ "gl", cmd("OpenMarkdownLink"), desc = "Go to markdown link or open url under cursor", noremap = true },

	--------------------------------------------- editing ---------------------------------------------
	{ "<S-j>", ":m '>+1<CR>gv=gv", desc = "Shift selected block down", mode = "v" },
	{ "<S-k>", ":m '<-2<CR>gv=gv", desc = "Shift selected block up", mode = "v" },
	{ "<", "<gv", desc = "Shift selected block left", mode = "v" },
	{ ">", ">gv", desc = "Shift selected block left", mode = "v" },
	{ "<S-down>", ":m '>+1<CR>gv=gv", desc = "Shift selected block down", mode = "v" },
	{ "<S-up>", ":m '<-2<CR>gv=gv", desc = "Shift selected block up", mode = "v" },
	{ "<S-left>", "<gv", desc = "Shift selected block left", mode = "v" },
	{ "<S-right>", ">gv", desc = "Shift selected block left", mode = "v" },
	{ "c", '"_c', desc = "Deletes stuff (puts it in the black hole register)", mode = { "n", "v" } },
	{ "C", '"_C', desc = "Deletes stuff (puts it in the black hole register)", mode = { "n", "v" } },
	{ "p", "P", desc = "Use P instead p in visual mode, to keep the contents of the register", mode = { "v" } },

	--------------------------------------------- windows ---------------------------------------------
	{ "<c-v>", cmd("vsplit"), desc = "Split [v]ertically" },
	{ "<C-down>", cmd("ZellijNavigateDown"), desc = "Go to window down" },
	{ "<C-up>",  cmd("ZellijNavigateUp"), desc = "Go to window up" },
	{ "<C-right>", cmd("ZellijNavigateRightTab"), desc = "Go to window right" },
	{ "<C-left>", cmd("ZellijNavigateLeftTab"), desc = "Go to window left" },

	--------------------------------------------- marks ---------------------------------------------
	{ "mm", "<Plug>(Marks-toggle)", desc = "Toggle mark" },
	{ "mn", "<Plug>(Marks-next)", desc = "Next mark" },
	{ "mp", "<Plug>(Marks-prev)", desc = "Previous mark" },
	{ "md", "<Plug>(Marks-delete)", desc = "Delete mark" },
	{ "mD", "<Plug>(Marks-deletebuf)", desc = "Delete marks in buffer" },
	{
		";",
		function()
			require("snipe-marks").open_marks_menu()
		end,
		desc = "Open (local) marks menu",
	},

	--------------------------------------------- quicklist ---------------------------------------------
	{
		"<leader>q",
		function()
			require("quicker").toggle()
		end,
		desc = "Toggle quickfix list",
	},

	--------------------------------------------- misc shit ---------------------------------------------
	{ "<Esc>", cmd("noh"), desc = "Remove highlight" },
	-- { "<leader>z", cmd("ZenMode"), desc = "Toggle zen-mode", mode = { "v", "i", "n" } },
	{
		"<leader>z",
		function()
			Snacks.zen.zen()
		end,
		desc = "Toggle zen-mode",
		mode = { "v", "i", "n" },
	},
	{ "<leader>N", cmd("set number!"), desc = "Toggle zen-mode", mode = { "v", "i", "n" } },
	-- { "d", '"_d', desc = "Deletes stuff (puts it in the black hole register)", mode = { "n", "v" } },
	-- { "D", '"_D', desc = "Deletes stuff (puts it in the black hole register)", mode = { "n", "v" } },
	{
		"<a-f>",
		cmd("ToggleTerm direction=float"),
		desc = "Open terminal in a floating window",
		mode = { "n", "i", "t" },
	},
	{ "<c-m>", cmd("NoiceAll"), desc = "Shows recent messages" },
	{ "<c-t>", cmd("ToggleMarkdownTodo"), desc = "Toggle markdown todo" },
	-- { "Q", "q" }, -- to prevent accidential recording (https://github.com/hrsh7th/nvim-cmp/issues/1692)
	-- { "q", "<nop>" },

	--------------------------------------------- flash ---------------------------------------------
	{
		"s",
		function()
			require("flash").jump()
		end,
		desc = "Flash",
		mode = { "n", "x", "o" },
	},
	{
		"S",
		function()
			require("flash").treesitter()
		end,
		desc = "Flash Treesitter",
		mode = { "n", "x", "o" },
	},
	{
		"r",
		function()
			require("flash").remote()
		end,
		desc = "Remote Flash",
		mode = "o",
	},
	{
		"R",
		function()
			require("flash").treesitter_search()
		end,
		desc = "Treesitter Search",
		mode = { "o", "x" },
	},
	{
		"<c-s>",
		function()
			require("flash").toggle()
		end,
		desc = "Toggle Flash Search",
		mode = { "c" },
	},
}

wk.add(wk_config)

-- remove garbage bindings
pcall(vim.keymap.del, "n", "grr")
pcall(vim.keymap.del, "n", "gra")
pcall(vim.keymap.del, "n", "grn")
