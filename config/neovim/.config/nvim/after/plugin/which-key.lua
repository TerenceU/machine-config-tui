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
	
	-- Git
	{ "<leader>g", group = "Git" },
	{ "<leader>gs", desc = "Stage Hunk" },
	{ "<leader>gr", desc = "Reset Hunk" },
	{ "<leader>gS", desc = "Stage Buffer" },
	{ "<leader>gu", desc = "Undo Stage Hunk" },
	{ "<leader>gR", desc = "Reset Buffer" },
	{ "<leader>gp", desc = "Git Pull" },
	{ "<leader>gP", desc = "Git Push" },
	{ "<leader>gPt", desc = "Git Push Tags" },
	{ "<leader>gc", desc = "Git Commit All" },
	{ "<leader>gt", desc = "Git Create Tag" },
	{ "<leader>gg", desc = "Open LazyGit" },
	{ "<leader>gb", desc = "Blame Line" },
	{ "<leader>gd", desc = "Diff This" },
	{ "<leader>gD", desc = "Diff This ~" },
	{ "<leader>gt", group = "Toggle" },
	{ "<leader>gtb", desc = "Toggle Line Blame" },
	{ "<leader>gtd", desc = "Toggle Deleted" },
	
	-- Treesitter context
	{ "<leader>t", group = "Toggle" },
	{ "<leader>tc", desc = "Toggle Sticky Context" },
	
	-- Window splits
	{ "<leader>|", desc = "Split Vertically" },
	{ "<leader>-", desc = "Split Horizontally" },
	
	-- Navigation
	{ "gd", desc = "Go to Definition" },
	{ "[d", desc = "Previous Diagnostic" },
	{ "]d", desc = "Next Diagnostic" },
	{ "[c", desc = "Previous Git Hunk" },
	{ "]c", desc = "Next Git Hunk" },
})

