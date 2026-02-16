-- Configurazione which-key (mostra keybindings disponibili)
require("which-key").setup({
	plugins = {
		marks = true,
		registers = true,
		spelling = {
			enabled = false,
		},
		presets = {
			operators = true,
			motions = true,
			text_objects = true,
			windows = true,
			nav = true,
			z = true,
			g = true,
		},
	},
	win = {
		border = "rounded",
		padding = { 2, 2, 2, 2 },
	},
})

-- Registra i keybindings con la nuova sintassi
local wk = require("which-key")
wk.add({
	{ "<leader><leader>", desc = "Toggle File Explorer" },
	{ "<leader><Tab>", desc = "Quick Buffer Switch" },
	{ "<leader>.", desc = "Code Action" },
	
	-- Telescope
	{ "<leader>f", group = "Find (Telescope)" },
	{ "<leader>ff", desc = "Find Files" },
	{ "<leader>fg", desc = "Git Files" },
	{ "<leader>fb", desc = "Buffers" },
	{ "<leader>fG", desc = "Live Grep" },
	
	-- LSP
	{ "<leader>l", group = "LSP" },
	{ "<leader>ld", desc = "Hover Documentation" },
	{ "<leader>lw", group = "Workspace" },
	{ "<leader>lws", desc = "Workspace Symbol" },
	
	-- Refactor/References
	{ "<leader>r", desc = "Rename" },
	{ "<leader>rr", desc = "References" },
	
	-- Explorer
	{ "<leader>e", group = "Explorer" },
	{ "<leader>ef", desc = "Find Current File in Tree" },
	
	-- Markdown
	{ "<leader>p", desc = "Preview File (MD/HTML)" },
	
	-- Noice
	{ "<leader>n", group = "Noice" },
	{ "<leader>nd", desc = "Dismiss Notifications" },
	{ "<leader>nh", desc = "Show History" },
	
	-- Save/Quit
	{ "<leader>w", group = "Save" },
	{ "<leader>ww", desc = "Save All Buffers" },
	{ "<leader>q", group = "Quit" },
	{ "<leader>qq", desc = "Quit All (asks for unsaved)" },
	{ "<leader>qw", desc = "Save and Quit All" },
	{ "<leader>qf", desc = "Force Quit All (no save)" },
	
	-- Clipboard
	{ "<leader>c", group = "Clipboard" },
	{ "<leader>cy", desc = "Copy to System Clipboard" },
	{ "<leader>cY", desc = "Copy Line to System Clipboard" },
	{ "<leader>cp", desc = "Paste from System Clipboard" },
	{ "<leader>cP", desc = "Paste Before from System Clipboard" },
	
	-- Window splits
	{ "<leader>|", desc = "Split Vertically" },
	{ "<leader>-", desc = "Split Horizontally" },
	
	-- Navigation
	{ "gd", desc = "Go to Definition" },
	{ "[d", desc = "Previous Diagnostic" },
	{ "]d", desc = "Next Diagnostic" },
})

