return function()
	require("blink.cmp").setup({
		keymap = { preset = "enter" },
		completion = {
			list = {
				selection = {
					preselect = function(ctx)
						return ctx.mode ~= "cmdline" and not require("blink.cmp").snippet_active({ direction = 1 })
					end,
					auto_insert = false,
				},
			},
		},
		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "normal",
			kind_icons = {
				-- Copilot = "",
				Text = "󰉿",
				Method = "󰊕",
				Function = "󰊕",
				Constructor = "󰒓",

				Field = "󰜢",
				Variable = "󰆦",
				Property = "󰖷",

				Class = "󱡠",
				Interface = "󱡠",
				Struct = "󱡠",
				Module = "󰅩",

				Unit = "󰪚",
				Value = "󰦨",
				Enum = "󰦨",
				EnumMember = "󰦨",

				Keyword = "󰻾",
				Constant = "󰏿",

				Snippet = "󱄽",
				Color = "󰏘",
				File = "󰈔",
				Reference = "󰬲",
				Folder = "󰉋",
				Event = "󱐋",
				Operator = "󰪚",
				TypeParameter = "󰬛",
			},
		},

		sources = {
			-- default = { "lsp", "copilot", "path", "buffer", "obsidian", "obsidian_new", "obsidian_tags" },
			default = { "lsp", "path", "buffer", "obsidian", "obsidian_new", "obsidian_tags", "emoji" },

			providers = {
				obsidian = { name = "obsidian", module = "blink.compat.source" },
				obsidian_new = { name = "obsidian_new", module = "blink.compat.source" },
				obsidian_tags = { name = "obsidian_tags", module = "blink.compat.source" },
				emoji = {
					name = "emoji",
					module = "blink.compat.source",
					transform_items = function(_, items)
						local kind = require("blink.cmp.types").CompletionItemKind.Text
						for i = 1, #items do
							items[i].kind = kind
						end
						return items
					end,
				},
				-- copilot = {
				--   name = "copilot",
				--   module = "blink-cmp-copilot",
				--   score_offset = 100,
				--   async = true,
				--   transform_items = function(_, items)
				--     local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
				--     local kind_idx = #CompletionItemKind + 1
				--     CompletionItemKind[kind_idx] = "Copilot"
				--     for _, item in ipairs(items) do
				--       item.kind = kind_idx
				--     end
				--     return items
				--   end,
				-- }
			},
		},

		signature = { enabled = true },
	})
end
