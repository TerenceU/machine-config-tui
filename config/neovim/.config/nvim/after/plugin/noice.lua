-- Configurazione Noice (UI moderna per cmdline e messaggi)
require("noice").setup({
	cmdline = {
		enabled = true,
		view = "cmdline",  -- Command line in basso (non popup centrato)
		format = {
			cmdline = { pattern = "^:", icon = ":", lang = "vim" },
			search_down = { kind = "search", pattern = "^/", icon = "/ ", lang = "regex" },
			search_up = { kind = "search", pattern = "^%?", icon = "? ", lang = "regex" },
			filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
			lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
			help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
		},
	},
	messages = {
		enabled = true,
		view = "notify",  -- Usa nvim-notify per i messaggi
		view_error = "notify",
		view_warn = "notify",
		view_history = "messages",
		view_search = "virtualtext",
	},
	popupmenu = {
		enabled = true,
		backend = "nui",  -- Popup menu moderno per autocompletion comandi
	},
	lsp = {
		progress = {
			enabled = true,
		},
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
	},
	presets = {
		bottom_search = true,  -- Search in basso
		command_palette = false,  -- Command palette NON centrato (in basso)
		long_message_to_split = true,  -- Messaggi lunghi in split
		inc_rename = false,
		lsp_doc_border = true,  -- Bordi per hover LSP
	},
	views = {
		cmdline_popup = {
			border = {
				style = "rounded",
			},
		},
	},
})

-- Configurazione nvim-notify
require("notify").setup({
	background_colour = "#000000",
	timeout = 3000,
	max_width = 50,
	stages = "fade",
})

-- Keybindings
vim.keymap.set("n", "<leader>nd", ":Noice dismiss<CR>", { desc = "Dismiss Noice notifications" })
vim.keymap.set("n", "<leader>nh", ":Noice history<CR>", { desc = "Show Noice history" })
