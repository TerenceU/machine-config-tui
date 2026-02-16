-- Configurazione GitHub Copilot
local copilot_ok, copilot = pcall(require, "copilot")
if not copilot_ok then
	return
end

copilot.setup({
	panel = {
		enabled = true,
		auto_refresh = false,
		keymap = {
			jump_prev = "[[",
			jump_next = "]]",
			accept = "<CR>",
			refresh = "gr",
			open = "<M-CR>"  -- Alt+Enter per aprire panel
		},
		layout = {
			position = "bottom",
			ratio = 0.4
		},
	},
	suggestion = {
		enabled = true,
		auto_trigger = true,
		debounce = 75,
		keymap = {
			accept = "<M-l>",  -- Alt+l per accettare suggerimento
			accept_word = false,
			accept_line = false,
			next = "<M-]>",  -- Alt+] per prossimo suggerimento
			prev = "<M-[>",  -- Alt+[ per precedente suggerimento
			dismiss = "<C-]>",  -- Ctrl+] per chiudere
		},
	},
	filetypes = {
		yaml = false,
		markdown = false,
		help = false,
		gitcommit = false,
		gitrebase = false,
		hgcommit = false,
		svn = false,
		cvs = false,
		["."] = false,
	},
	copilot_node_command = 'node',
	server_opts_overrides = {},
})

-- NOTA: Dopo l'installazione esegui :Copilot auth per autenticarti con GitHub
